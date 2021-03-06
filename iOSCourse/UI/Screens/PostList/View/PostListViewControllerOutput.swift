//

import Foundation

protocol PostListViewControllerOutput: AnyObject, ViewOutput {
    func didSelectCell(with indexPath: IndexPath)
    func didSelectCellSwipeActionRead(with indexPath: IndexPath)
    func didSelectLogout()
    func didSelectAddButton()
    func refreshPosts()
}
