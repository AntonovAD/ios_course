//

import Foundation

protocol PostCardViewOutput: AnyObject, ViewOutput {
    func didSelectTag(with indexPath: IndexPath)
}
