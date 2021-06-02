//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let text: String
    let status_id: Int
    let author_id: Int
    let created_at: String
    let updated_at: String?
    let deleted_at: String?
    let likes: Int
    let dislikes: Int
    let status: PostStatus
    let author: PostAuthor
    let tags: [PostTag]
    let comments: [PostComment]
    let popular_comment: PostComment
}

struct PostStatus: Codable {
    let id: Int
    let name: String
    let created_at: String
    let updated_at: String?
    let deleted_at: String?
}

struct PostAuthor: Codable {
    let id: Int
    let lname: String
    let fname: String
    let user_id: Int
    let created_at: String
    let updated_at: String?
    let deleted_at: String?
}

struct PostTag: Codable {
    let id: Int
    let name: String
    let created_at: String
    let updated_at: String?
    let deleted_at: String?
    
    struct Pivot: Codable {
        let post_id: Int
        let tag_id: Int
    }
    let pivot: Pivot
}

struct PostComment: Codable {
    
}
