//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let password: String
    let email: String
    let created_at: String
    let updated_at: String?
    let deleted_at: String?
}
