//

import Foundation

protocol PostInfoViewPresenterFactoryProtocol {
    func createPostInfoViewPresenter(post: Post) -> PostInfoViewPresenter
}

class PostInfoViewPresenterFactory: PostInfoViewPresenterFactoryProtocol {
    func createPostInfoViewPresenter(post: Post) -> PostInfoViewPresenter {
        return PostInfoViewPresenter(
            post: post
        )
    }
}
