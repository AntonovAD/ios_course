//

import Foundation

class PostTextViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = PostTextView.self
    
    private(set) var post: Post
    
    weak var view: PostTextViewInput?
    
    init(
        post: Post
    ) {
        self.post = post
    }
}

extension PostTextViewPresenter: PostTextViewOutput {
    func viewIsReady() {
        updatePostText()
    }
}

private extension PostTextViewPresenter {
    func updatePostText() {
        view?.updatePostText(text: post.text)
    }
}
