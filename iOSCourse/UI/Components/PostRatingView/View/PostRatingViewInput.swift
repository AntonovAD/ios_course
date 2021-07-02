//

import Foundation
import UIKit

protocol PostRatingViewInput: AnyObject {
    func updateLikeColor(backgroundColor: UIColor, textColor: UIColor)
    func updateLikes(text: String)
    func updateDislikeColor(backgroundColor: UIColor, textColor: UIColor)
    func updateDislikes(text: String)
}
