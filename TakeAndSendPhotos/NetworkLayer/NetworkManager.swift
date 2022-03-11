//
//  Network.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//


import Alamofire

protocol NetworkProtocol {
    func logIn(email: String, password: String, onCompletion: @escaping (String) -> Void)
    func upLoadPhoto()
}

struct Login: Encodable {
    let email: String
    let password: String
}
 
class NetworkManager: NetworkProtocol {
    let keychain = KeychainHelper()
    enum Static {
        static let baseUrl = "https://test.dewival.com/api/"
    }
   
    func logIn(email: String, password: String, onCompletion: @escaping (String) -> Void) {
//        let parameters = Login(email: email, password: password)
        
        guard let endpointUrl = URL(string: Static.baseUrl + "login/") else {
            return
        }
        
        //Make JSON to send request to server
        var json = [String:Any]()
        
        json["login"] = "test"
        json["password"] = "123456".toBase64()
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
//            let accessToken =
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                            
           
            let task = URLSession.shared.dataTask(with: request) { data2, res, err in
                
                if let httpResponse = res as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        self.keychain.set(value: email, key: "login")
                        self.keychain.set(value: password, key: "pwass")
                        // safe login and password
                        let string = try! JSONSerialization.jsonObject(with: data2!, options: [.allowFragments])
                        //
                        onCompletion(string as! String)
                    }
                }
                
            }
            task.resume()
            
            
        }catch{
            print(error)
        }
    }
    
    func upLoadPhoto() {
        let fileURL = Bundle.main.url(forResource: "photo", withExtension: "jpg")
        
        //        AF.upload(fileURL, to: "https://test.dewival.com/api/sendfile/").responseDecodable(of: DecodableType.self) { response in
        //            debugPrint(response)
        //        }
    }
}


extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}



// MARK: - пример авторизации по кнопке (заполнение текстфилдов + кнопка логин)

private let url = "https://test.dewival.com/api/login/"
var parameters = ["user": "test", "password": "123456"]
//    var token = ["...": ""]

// Parameters textfields
//@IBOutlet weak var userTF: UITextField?
//@IBOutlet weak var passwordTF: UITextField?
//
//// A method for the login button
//@IBAction func loginButton(_ sender: UIButton) {
//    parameters["user"] = userTF?.text
//    parameters["password"] = passwordTF?.text
//    AF.request(url,
//               method: .post,
//               parameters: parameters,
//               encoder: JSONParameterEncoder.default).response { response in
//        debugPrint(response)
//
//
//            //Reading JWT authentication token from the server
//            if let tokenString = response.result.value as? String {
//                self.token["..."] = tokenString
//            }
//
//
//    }
//}


// MARK: - CRUD реализация

//class CRUDAuthorization {
//    enum Router: URLRequestConvertible {
//        case createUser(parameters: Parameters)
//        case readUser(username: String)
//        case updateUser(username: String, parameters: Parameters)
//        case destroyUser(username: String)
//
//        static let baseURLString = "https://example.com"
//
//        var method: HTTPMethod {
//            switch self {
//            case .createUser:
//                return .post
//            case .readUser:
//                return .get
//            case .updateUser:
//                return .put
//            case .destroyUser:
//                return .delete
//            }
//        }
//
//        var path: String {
//            switch self {
//            case .createUser:
//                return "/users"
//            case .readUser(let username):
//                return "/users/\(username)"
//            case .updateUser(let username, _):
//                return "/users/\(username)"
//            case .destroyUser(let username):
//                return "/users/\(username)"
//            }
//        }
//
//        // MARK: URLRequestConvertible
//
//        func asURLRequest() throws -> URLRequest {
//            let url = try Router.baseURLString.asURL()
//
//            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
//            urlRequest.httpMethod = method.rawValue
//
//            switch self {
//            case .createUser(let parameters):
//                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//            case .updateUser(_, let parameters):
//                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//            default:
//                break
//            }
//
//            return urlRequest
//        }
//    }
//}
