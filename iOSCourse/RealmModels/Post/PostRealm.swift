//

import Foundation
import RealmSwift

class PostRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    //@objc dynamic var status_id = 0
    //@objc dynamic var author_id = 0
    //@objc dynamic var created_at = ""
    //@objc dynamic var updated_at = ""
    //@objc dynamic var deleted_at = ""
    //@objc dynamic var likes = 0
    //@objc dynamic var dislikes = 0
    //@objc dynamic var status: PostStatusRealm?
    //@objc dynamic var author: PostAuthorRealm?
    //let tags = RealmSwift.List<PostTagRealm>()
    //let comments = RealmSwift.List<PostCommentRealm>()
    //@objc dynamic var popular_comment: PostCommentRealm?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(from plain: Post) {
        self.init()
        self.id = plain.id
        self.title = plain.title
        self.text = plain.text
        //self.status_id = plain.status_id
        //self.author_id = plain.author_id
        //self.created_at = plain.created_at
        //self.updated_at = plain.updated_at ?? ""
        //self.deleted_at = plain.deleted_at ?? ""
        //self.likes = plain.likes
        //self.dislikes = plain.dislikes
        //self.status = PostStatusRealm(from: plain.status)
        //self.author = PostAuthorRealm(from: plain.author)
        //plain.tags.forEach { self.tags.append(PostTagRealm(from: $0)) }
        //plain.comments.forEach { self.comments.append(PostCommentRealm(from: $0)) }
        //self.popular_comment = PostCommentRealm(from: plain.popular_comment)
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
            text: text,
            
            status_id: 0,
            author_id: 0,
            created_at: "",
            updated_at: nil,
            deleted_at: nil,
            likes: 0,
            dislikes: 0,
            
            //status_id: status_id,
            //author_id: author_id,
            //created_at: created_at,
            //updated_at: !(updated_at.isEmpty) ? updated_at : nil,
            //deleted_at: !(deleted_at.isEmpty) ? deleted_at : nil,
            //likes: likes,
            //dislikes: dislikes,
            //status: (status?.toPlain())!,
            status: postStatus,
            //author: (author?.toPlain())!,
            author: postAuthor,
            //tags: tags.map { $0.toPlain() },
            tags: [],
            //comments: comments.map { $0.toPlain() },
            comments: [],
            //popular_comment: (popular_comment?.toPlain())!
            popular_comment: postComment,
            
            your_likes: 0,
            your_dislikes: 0
        )
    }
}
