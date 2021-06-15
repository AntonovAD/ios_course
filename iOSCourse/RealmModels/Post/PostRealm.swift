//

import Foundation
import RealmSwift

class PostRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(from plain: Post) {
        self.init()
        self.id = plain.id
        self.title = plain.title
    }
    
    func toPlain() -> Post {
        let postStatus = PostStatus(
            id: 0,
            name: "name",
            created_at: "",
            updated_at: nil,
            deleted_at: nil
        )
        
        let postAuthor = PostAuthor(
            id: 0,
            lname: "lname",
            fname: "fname",
            user_id: 0,
            created_at: "",
            updated_at: nil,
            deleted_at: nil
        )
        
        let postComment = PostComment()
        
        return Post(
            id: id,
            title: title,
            text: "text",
            status_id: 0,
            author_id: 0,
            created_at: "",
            updated_at: nil,
            deleted_at: nil,
            likes: 0,
            dislikes: 0,
            status: postStatus,
            author: postAuthor,
            tags: [],
            comments: [],
            popular_comment: postComment
        )
    }
}
