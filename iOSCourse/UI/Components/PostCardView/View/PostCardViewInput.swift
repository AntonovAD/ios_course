//

import Foundation
import UIKit

protocol PostCardViewInput: AnyObject {
    func updateTitle(text: String)
    func updateAuthor(text: String)
    func updateDate(text: String)
    func updateLikeColor(backgroundColor: UIColor, textColor: UIColor)
    func updateLikes(text: String)
    func updateDislikeColor(backgroundColor: UIColor, textColor: UIColor)
    func updateDislikes(text: String)
    func reloadTags()
}
