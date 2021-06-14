//

import Foundation

protocol PostCardViewPresenterFactoryProtocol {
    func createPostCardViewPresenter(post: Post) -> PostCardViewPresenter
}

class namePostCardViewPresenterFactory: PostCardViewPresenterFactoryProtocol {
    func createPostCardViewPresenter(post: Post) -> PostCardViewPresenter {
        return PostCardViewPresenter(post: post)
    }
}
