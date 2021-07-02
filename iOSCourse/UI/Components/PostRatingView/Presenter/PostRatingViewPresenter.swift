//

import Foundation
import UIKit

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
        updateLikeColor()
        updateLikes()
        
        updateDislikeColor()
        updateDislikes()
    }
}

private extension PostRatingViewPresenter {
    func updateLikeColor() {
        let yourLike = post.your_likes > 0
        
        view?.updateLikeColor(
            backgroundColor: yourLike
                ? .systemGreen
                : UIColor.appColor(.secondaryFill) ?? .clear,
            textColor: yourLike
                ? .white
                : .lightGray
        )
    }
    
    func updateLikes() {
        view?.updateLikes(text: "\(post.likes)")
    }
    
    func updateDislikeColor() {
        let yourDislike = post.your_dislikes > 0
        
        view?.updateDislikeColor(
            backgroundColor: yourDislike
                ? .systemRed
                : UIColor.appColor(.secondaryFill) ?? .clear,
            textColor: yourDislike
                ? .white
                : .lightGray
        )
    }
    
    func updateDislikes() {
        view?.updateDislikes(text: "\(post.dislikes)")
    }
}
