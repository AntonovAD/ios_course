//

import Foundation

extension APIResponse {
    enum User {
        
    }
}

extension APIResponse.User {
    struct SignIn: Codable {
        let result: Bool
        let userId: Int
    }
}
