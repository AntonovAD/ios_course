//

import Foundation

protocol PostRatingViewPresenterFactoryProtocol {
    func createPostRatingViewPresenter(
        post: Post,
        likeAction: @escaping (_ post: Post) -> Void,
        dislikeAction: @escaping (_ post: Post) -> Void
    ) -> PostRatingViewPresenter
}

class PostRatingViewPresenterFactory: PostRatingViewPresenterFactoryProtocol {
    func createPostRatingViewPresenter(
        post: Post,
        likeAction: @escaping (_ post: Post) -> Void,
        dislikeAction: @escaping (_ post: Post) -> Void
    ) -> PostRatingViewPresenter {
        return PostRatingViewPresenter(
            post: post,
            likeAction: likeAction,
            dislikeAction: dislikeAction
        )
    }
}
