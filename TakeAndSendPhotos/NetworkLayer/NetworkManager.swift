//
//  Network.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//

import UIKit
import Alamofire

// HTTP (CRUD)
protocol NetworkProtocol {
    func authorization()
}

struct Login: Encodable {
    let email: String
    let password: String
}

// доработать нетворкмэнаджер, найти шаблонное решение (функционал по CRUD) 
class NetworkManager: NetworkProtocol {

    let login = Login(email: "test", password: "123456")

    func authorization() {
        AF.request("https://test.dewival.com/api/login/",
                   method: .post,
                   parameters: login,
                   encoder: URLEncodedFormEncoder(dataEncoding: .base64) as! ParameterEncoder).response { response in
            debugPrint(response)
        }
    }
}





// MARK: - пример авторизации по кнопке (заполнение текстфилдов + кнопка логин)

private let url = "https://test.dewival.com/api/login/"
var parameters = ["user": "test", "password": "123456"]
//    var token = ["X-Auth-Token": ""]

// Parameters textfields
@IBOutlet weak var userTF: UITextField?
@IBOutlet weak var passwordTF: UITextField?

// A method for the login button
@IBAction func loginButton(_ sender: UIButton) {
    parameters["user"] = userTF?.text
    parameters["password"] = passwordTF?.text
    AF.request(url,
               method: .post,
               parameters: parameters,
               encoder: JSONParameterEncoder.default).response { response in
        debugPrint(response)


            //Reading JWT authentication token from the server
            if let tokenString = response.result.value as? String {
                self.token["X-Auth-Token"] = tokenString
            }


    }
}


// MARK: - CRUD реализация

class CRUDAuthorization {
    enum Router: URLRequestConvertible {
        case createUser(parameters: Parameters)
        case readUser(username: String)
        case updateUser(username: String, parameters: Parameters)
        case destroyUser(username: String)

        static let baseURLString = "https://example.com"

        var method: HTTPMethod {
            switch self {
            case .createUser:
                return .post
            case .readUser:
                return .get
            case .updateUser:
                return .put
            case .destroyUser:
                return .delete
            }
        }

        var path: String {
            switch self {
            case .createUser:
                return "/users"
            case .readUser(let username):
                return "/users/\(username)"
            case .updateUser(let username, _):
                return "/users/\(username)"
            case .destroyUser(let username):
                return "/users/\(username)"
            }
        }

        // MARK: URLRequestConvertible

        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURLString.asURL()

            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue

            switch self {
            case .createUser(let parameters):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            case .updateUser(_, let parameters):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            default:
                break
            }

            return urlRequest
        }
    }
}
