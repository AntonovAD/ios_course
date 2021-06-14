//

import Foundation

struct Author: Codable {
    let id: Int
    let lname: String
    let fname: String
    let user_id: Int
    let user: User
    let created_at: String
    let updated_at: String?
    let deleted_at: String?
}
