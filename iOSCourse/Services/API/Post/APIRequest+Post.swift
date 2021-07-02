//

import Foundation

extension APIRequest {
    enum Post {
        
    }
}

extension APIRequest.Post {
    struct GetRecent: Encodable {}
    
    struct Rate: Encodable {
        let postId: Int
        let value: Int
    }
}
