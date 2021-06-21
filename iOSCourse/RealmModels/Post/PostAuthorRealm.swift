//

import Foundation
import RealmSwift

class PostAuthorRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var lname = ""
    @objc dynamic var fname = ""
    @objc dynamic var user_id = 0
    @objc dynamic var created_at = ""
    @objc dynamic var updated_at = ""
    @objc dynamic var deleted_at = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(from plain: PostAuthor) {
        self.init()
        self.id = plain.id
        self.lname = plain.lname
        self.fname = plain.fname
        self.user_id = plain.user_id
        self.created_at = plain.created_at
        self.updated_at = plain.updated_at ?? ""
        self.deleted_at = plain.deleted_at ?? ""
    }
    
    func toPlain() -> PostAuthor {
        return PostAuthor(
            id: id,
            lname: lname,
            fname: fname,
            user_id: user_id,
            created_at: created_at,
            updated_at: !(updated_at.isEmpty) ? updated_at : nil,
            deleted_at: !(deleted_at.isEmpty) ? deleted_at : nil
        )
    }
}
