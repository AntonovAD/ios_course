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
        
    }
}
