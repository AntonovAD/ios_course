//

import Foundation

protocol PostCardViewInput: AnyObject {
    func updateTitle(text: String)
    func updateAuthor(text: String)
    func updateDate(text: String)
    func updateLikes(like: Int, dislike: Int)
    func updateTags(tags: [String])
}
