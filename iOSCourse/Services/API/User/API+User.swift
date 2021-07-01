//

import Foundation

extension API {
    enum User {
        
    }
}

extension API.User {
    struct SignIn: RequestProtocol {
        typealias ParametersType = APIRequest.User.SignIn
        typealias ResponseType = APIResponse.User.SignIn
        typealias ErrorType = Error
        
        init(_ parameters: ParametersType) {
            self.parameters = parameters
        }
        
        let url: String = "http://localhost:8081/api/user/login"
        let method: HTTPMethod = .post
        let parameters: ParametersType
        let encodingType: EncodingType? = .json(encoder: JSONEncoder())
        
        struct Error: RequestErrorProtocol {
            let code: Int?
            let data: [String: Any]?
            
            init(code: Int?, data: Data?) {
                self.code = code
                self.data = try? JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any]
            }
            
            init(isReachable: Bool?, data: Data?) {
                self.code = 500
                self.data = try? JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any]
            }
        }
    }
}
