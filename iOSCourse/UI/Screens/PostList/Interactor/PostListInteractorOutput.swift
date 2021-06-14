//

import Foundation

protocol PostListInteractorOutput: AnyObject {
    func updatePostListCellPresenters(_ presenters: [PostCardViewPresenter])
    func handleError(_ error: Error)
}
