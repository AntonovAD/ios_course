//

import Foundation

protocol PostListViewControllerOutput: AnyObject {
    func viewIsReady()
    func didSelectCell(with indexPath: IndexPath)
}
