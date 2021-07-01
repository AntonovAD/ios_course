//

import Foundation

extension APIRequest {
    enum User {
        
    }
}

extension APIRequest.User {
    struct SignIn: Encodable {
        let login: String
        let password: String
    }
}
