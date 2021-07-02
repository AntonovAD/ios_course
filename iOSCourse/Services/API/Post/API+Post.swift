//

import Foundation

extension API {
    enum Post {
        
    }
}

extension API.Post {
    struct GetRecent: RequestProtocol {
        typealias ParametersType = APIRequest.Post.GetRecent
        typealias ResponseType = [Post]
        typealias ErrorType = APIError
        
        init(_ parameters: ParametersType) {
            self.parameters = parameters
        }
        
        let url: String = "http://localhost:8081/api/post/get/posts/recent"
        let method: HTTPMethod = .post
        let parameters: ParametersType
    }
    
    struct Rate: RequestProtocol {
        typealias ParametersType = APIRequest.Post.Rate
        typealias ResponseType = Post
        typealias ErrorType = APIError
        
        init(_ parameters: ParametersType) {
            self.parameters = parameters
        }
        
        let url: String = "http://localhost:8081/api/post/rate/post"
        let method: HTTPMethod = .post
        let parameters: ParametersType
        let encodingType: EncodingType? = .json(encoder: JSONEncoder())
    }
}
