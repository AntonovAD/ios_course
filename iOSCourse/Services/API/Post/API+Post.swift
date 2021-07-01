//

import Foundation

extension API {
    enum Post {
        
    }
}

extension API.Post {
    struct GetRecent: RequestProtocol {
        typealias ParametersType = Parameters
        typealias ResponseType = [Post]
        typealias ErrorType = Error
        
        let url: String = "http://localhost:8081/api/post/get/posts/recent"
        let method: HTTPMethod = .post
        let parameters: Parameters = .init()
        
        struct Parameters: Encodable {
            
        }
        
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
