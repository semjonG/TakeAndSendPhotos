//
//  Network.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//


import Alamofire

// HTTP (CRUD)
protocol NetworkProtocol {
    func logIn(email: String, password: String, onCompletion: @escaping (Bool) -> Void)
    func upLoadPhoto()
}

struct Login: Encodable {
    let email: String
    let password: String
}

// доработать нетворкмэнаджер, найти шаблонное решение (функционал по CRUD) 
class NetworkManager: NetworkProtocol {
    
    enum Static {
        static let baseUrl = "https://test.dewival.com/api/"
    }
    

    
    
    func logIn(email: String, password: String, onCompletion: @escaping (Bool) -> Void) {
        let parameters = Login(email: email, password: password)
        AF.request(Static.baseUrl + "login/",
                   method: .post,
                   parameters: parameters,
                   encoder: URLEncodedFormEncoder(dataEncoding: .base64) as! ParameterEncoder).response { response in
//            if true {
                onCompletion(true)
//            }
        }
    }
    
    func upLoadPhoto() {
        let fileURL = Bundle.main.url(forResource: "photo", withExtension: "jpg")

//        AF.upload(fileURL, to: "https://test.dewival.com/api/sendfile/").responseDecodable(of: DecodableType.self) { response in
//            debugPrint(response)
//        }
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
