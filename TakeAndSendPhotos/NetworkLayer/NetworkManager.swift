//
//  Network.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//


import UIKit

protocol NetworkProtocol {
    func logIn(email: String, password: String, onCompletion: @escaping (Bool) -> Void)
}

struct Login: Encodable {
    let email: String
    let password: String
}

class NetworkManager: NetworkProtocol {
    
    let keychain = KeychainManager()
    
    enum Static {
        static let baseUrl = "https://test.dewival.com/api/"
    }
    
    func logIn(email: String, password: String, onCompletion: @escaping (Bool) -> Void) {
        
        guard let endpointUrl = URL(string: Static.baseUrl + "login/") else { return }
        
        //Make JSON to send request to server
        var json = [String:Any]()
        
        json["login"] = email
        json["password"] = password.toBase64()
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            let accessToken = ""
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data2, res, err in
                
                if let httpResponse = res as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
               
                        // save login and password
                        self.keychain.save(key: "login", value: email)
                        self.keychain.save(key: "password", value: password)
                        // save token
                        let string = try! JSONSerialization.jsonObject(with: data2!, options: [.allowFragments])
                        self.keychain.save(key: "token", value: string)
                        
                        onCompletion(true)
                    }
                }
            }
            task.resume()
            
        }catch{
            print(error)
        }
    }
    
    func uploadImage(image: Data, onCompletion: @escaping (Bool) -> ()) {
        let url = URL(string: Static.baseUrl + "sendfile/")
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        let token = keychain.get(key: "token") as! String
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        print(token)
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                onCompletion(false)
                return
            }
            
            if httpResponse.statusCode == 401 || httpResponse.statusCode == 403 {
                guard let login = self.keychain.get(key: "login") as? String,
                      let pass = self.keychain.get(key: "password") as? String else {
                    onCompletion(false)
                    return
                }
                self.logIn(email: login, password: pass) { res in
                    onCompletion(res)
                }
            }
            
            if error == nil {
                
                if httpResponse.statusCode == 200 {
                    onCompletion(true)
                }
                
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            } else {
                onCompletion(false)
            }
        }).resume()
    }
}

extension String {
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

