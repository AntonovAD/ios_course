//

import Foundation
import RealmSwift

class PostStatusRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var created_at = ""
    @objc dynamic var updated_at = ""
    @objc dynamic var deleted_at = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(from plain: PostStatus) {
        self.init()
        self.id = plain.id
        self.name = plain.name
        self.created_at = plain.created_at
        self.updated_at = plain.updated_at ?? ""
        self.deleted_at = plain.deleted_at ?? ""
    }
    
    func toPlain() -> PostStatus {
        return PostStatus(
            id: id,
            name: name,
            created_at: created_at,
            updated_at: !(updated_at.isEmpty) ? updated_at : nil,
            deleted_at: !(deleted_at.isEmpty) ? deleted_at : nil
        )
    }
}
