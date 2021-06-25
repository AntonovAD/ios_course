//

import Foundation

protocol PostListInteractorOutput: AnyObject {
    func updatePostListCellPresenters(_ presenters: [PostCardViewPresenter])
    func updateUserInfo(_ name: String, _ email: String)
    func handleError(_ error: Error)
}
