//

import Foundation
import RealmSwift

class PostCommentRealm: Object {
    convenience init(from plain: PostComment) {
        self.init()
    }
    
    func toPlain() -> PostComment {
        return PostComment()
    }
}
