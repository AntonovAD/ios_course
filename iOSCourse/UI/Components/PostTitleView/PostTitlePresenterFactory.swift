//

import Foundation

protocol PostTitleViewPresenterFactoryProtocol {
    func createPostTitleViewPresenter(post: Post) -> PostTitleViewPresenter
}

class PostTitleViewPresenterFactory: PostTitleViewPresenterFactoryProtocol {
    func createPostTitleViewPresenter(post: Post) -> PostTitleViewPresenter {
        return PostTitleViewPresenter(
            post: post
        )
    }
}
