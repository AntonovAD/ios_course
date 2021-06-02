//

import Foundation

protocol PostListViewControllerInput: AnyObject {
    func reloadTable()
    func updateTitle(_ text: String)
}
