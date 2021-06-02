//

import Foundation

class PostCardViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = PostCardView.self
    
    private(set) var post: Post
    
    weak var view: PostCardViewInput?
    
    init(post: Post) {
        self.post = post
    }
}

extension PostCardViewPresenter: PostCardViewOutput {
    func viewIsReady() {
        updateTitle()
        updateAuthor()
        updateDate()
        updateLikes()
        updateTags()
    }
}

private extension PostCardViewPresenter {
    func updateTitle() {
        view?.updateTitle(text: post.title)
    }
    
    func updateAuthor() {
        view?.updateAuthor(text: "\(post.author.lname) \(post.author.fname)")
    }
    
    func updateDate() {
        view?.updateDate(text: post.updated_at ?? post.created_at)
    }
    
    func updateLikes() {
        view?.updateLikes(like: post.likes, dislike: post.dislikes)
    }
    
    func updateTags() {
        view?.updateTags(tags: post.tags.map { $0.name })
    }
}
