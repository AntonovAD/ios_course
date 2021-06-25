//

import Foundation

protocol PostViewControllerInput: AnyObject {
    func reloadTable()
    func updateTitle(_ text: String)
}
