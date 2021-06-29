//

import Foundation

class PostTitleViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = PostTitleView.self
    
    private(set) var post: Post
    
    weak var view: PostTitleViewInput?
    
    init(
        post: Post
    ) {
        self.post = post
    }
}

extension PostTitleViewPresenter: PostTitleViewOutput {
    func viewIsReady() {
        updatePostTitle()
    }
}

private extension PostTitleViewPresenter {
    func updatePostTitle() {
        view?.updatePostTitle(text: post.title)
    }
}
