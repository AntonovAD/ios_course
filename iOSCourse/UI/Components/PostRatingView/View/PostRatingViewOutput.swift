//

import Foundation

protocol PostRatingViewOutput: AnyObject, ViewOutput {
    func likeDidSelect()
    func dislikeDidSelect()
}
