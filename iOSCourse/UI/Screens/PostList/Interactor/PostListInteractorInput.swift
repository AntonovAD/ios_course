//

import Foundation

protocol PostListInteractorInput: AnyObject {
    func requestPosts()
    func requestUser()
    func didSelectLogout()
    func didSelectAddButton()
}
