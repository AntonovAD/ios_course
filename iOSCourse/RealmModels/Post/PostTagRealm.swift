//

import Foundation
import RealmSwift

class PostTagRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var created_at = ""
    @objc dynamic var updated_at = ""
    @objc dynamic var deleted_at = ""
    @objc dynamic var pivot: Pivot?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(from plain: PostTag) {
        self.init()
        self.id = plain.id
        self.name = plain.name
        self.created_at = plain.created_at
        self.updated_at = plain.updated_at ?? ""
        self.deleted_at = plain.deleted_at ?? ""
        self.pivot = Pivot(from: plain.pivot)
    }
    
    func toPlain() -> PostTag {
        return PostTag(
            id: id,
            name: name,
            created_at: created_at,
            updated_at: !(updated_at.isEmpty) ? updated_at : nil,
            deleted_at: !(deleted_at.isEmpty) ? deleted_at : nil,
            pivot: (pivot?.toPlain())!
        )
    }
}

class Pivot: Object {
    @objc dynamic var post_id = 0
    @objc dynamic var tag_id = 0
    
    convenience init(from plain: PostTag.Pivot) {
        self.init()
        self.post_id = plain.post_id
        self.tag_id = plain.tag_id
    }
    
    func toPlain() -> PostTag.Pivot {
        return PostTag.Pivot(
            post_id: post_id,
            tag_id: tag_id
        )
    }
}
