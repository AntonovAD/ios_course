//

import Foundation

protocol PostInteractorOutput: AnyObject {
    func updatePostCellPresenters(_ presenters: [CellPresenter])
    func handleError(_ error: Error)
}
