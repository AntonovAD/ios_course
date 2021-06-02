//

import Foundation

protocol PostListInteractorOutput: AnyObject {
    func updateCellPresenters(_ presenters: [PostCardViewPresenter])
    func handleError(_ error: Error)
}
