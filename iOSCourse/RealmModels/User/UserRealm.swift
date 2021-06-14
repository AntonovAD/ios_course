//

import Foundation
import RealmSwift

class UserRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var password = ""
    @objc dynamic var email = ""
    @objc dynamic var created_at = ""
    @objc dynamic var updated_at: String?
    @objc dynamic var deleted_at: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(from plain: User) {
        self.init()
        self.id = plain.id
        self.name = plain.name
        self.password = plain.password
        self.email = plain.email
        self.created_at = plain.created_at
        self.updated_at = plain.updated_at
        self.deleted_at = plain.deleted_at
    }
    
    func toPlain() -> User {
        return User(
            id: id,
            name: name,
            password: password,
            email: email,
            created_at: created_at,
            updated_at: updated_at,
            deleted_at: deleted_at
        )
    }
}
