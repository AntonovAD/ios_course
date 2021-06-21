//

import Foundation

protocol PostListViewControllerInput: AnyObject {
    func reloadTable()
    func updateTitle(_ text: String)
    func updateUserInfo(_ name: String, _ email: String)
}
