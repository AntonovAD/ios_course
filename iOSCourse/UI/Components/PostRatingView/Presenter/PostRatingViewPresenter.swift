//

import Foundation

class PostRatingViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = PostRatingView.self
    
    private(set) var post: Post
    
    weak var view: PostRatingViewInput?
    
    init(
        post: Post
    ) {
        self.post = post
    }
}

extension PostRatingViewPresenter: PostRatingViewOutput {
    func viewIsReady() {
        updateLikes()
        updateDislikes()
    }
}

private extension PostRatingViewPresenter {
    func updateLikes() {
        view?.updateLikes(text: "\(post.likes)")
    }
    
    func updateDislikes() {
        view?.updateDislikes(text: "\(post.dislikes)")
    }
}
