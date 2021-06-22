//

import Foundation

protocol PostListInteractorOutput: AnyObject {
    func updatePostListCellPresenters(_ presenters: [PostCardViewPresenter])
    func updateUserInfo(_ name: String, _ email: String)
    // id: Int
    func navigateToPost()
    
    func handleError(_ error: Error)
}
