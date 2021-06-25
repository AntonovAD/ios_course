//

import Foundation

class PostInfoViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = PostInfoView.self
    
    private(set) var post: Post
    
    weak var view: PostInfoViewInput?
    
    init(
        post: Post
    ) {
        self.post = post
    }
}

extension PostInfoViewPresenter: PostInfoViewOutput {
    func viewIsReady() {
        updateAuthorName()
        updatePostDate()
    }
}

private extension PostInfoViewPresenter {
    func updateAuthorName() {
        view?.updateAuthorName(text: "\(post.author.lname) \(post.author.fname)")
    }
    
    func updatePostDate() {
        view?.updatePostDate(text: post.updated_at ?? post.created_at)
    }
}
