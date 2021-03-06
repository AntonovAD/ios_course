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
        typealias ErrorType = APIError
        
        init(_ parameters: ParametersType) {
            self.parameters = parameters
        }
        
        let url: String = "http://localhost:8081/api/user/login"
        let method: HTTPMethod = .post
        let parameters: ParametersType
        let encodingType: EncodingType? = .json(encoder: JSONEncoder())
    }
    
    struct Get: RequestProtocol {
        typealias ParametersType = APIRequest.User.Get
        typealias ResponseType = User
        typealias ErrorType = APIError
        
        init(_ parameters: ParametersType) {
            self.parameters = parameters
        }
        
        let url: String = "http://localhost:8081/api/user/get"
        let method: HTTPMethod = .get
        let parameters: ParametersType
        let encodingType: EncodingType? = .none
    }
}
