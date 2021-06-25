//

import Foundation

protocol PostTextViewPresenterFactoryProtocol {
    func createPostTextViewPresenter(post: Post) -> PostTextViewPresenter
}

class PostTextViewPresenterFactory: PostTextViewPresenterFactoryProtocol {
    func createPostTextViewPresenter(post: Post) -> PostTextViewPresenter {
        return PostTextViewPresenter(
            post: post
        )
    }
}
