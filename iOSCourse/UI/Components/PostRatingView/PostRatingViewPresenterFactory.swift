//

import Foundation

protocol PostRatingViewPresenterFactoryProtocol {
    func createPostRatingViewPresenter(post: Post) -> PostRatingViewPresenter
}

class PostRatingViewPresenterFactory: PostRatingViewPresenterFactoryProtocol {
    func createPostRatingViewPresenter(post: Post) -> PostRatingViewPresenter {
        return PostRatingViewPresenter(
            post: post
        )
    }
}
