//

import Foundation

protocol PostRatingViewInput: AnyObject {
    func updateLikes(text: String)
    func updateDislikes(text: String)
}
