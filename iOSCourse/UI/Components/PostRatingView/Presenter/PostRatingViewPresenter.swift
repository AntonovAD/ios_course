//

import Foundation
import UIKit

class PostRatingViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = PostRatingView.self
    
    private(set) var post: Post
    
    private let likeAction: (_ post: Post) -> Void
    private let dislikeAction: (_ post: Post) -> Void
    
    weak var view: PostRatingViewInput?
    
    init(
        post: Post,
        likeAction: @escaping (_ post: Post) -> Void = { _ in return },
        dislikeAction: @escaping (_ post: Post) -> Void = { _ in return }
    ) {
        self.post = post
        self.likeAction = likeAction
        self.dislikeAction = dislikeAction
    }
}

extension PostRatingViewPresenter: PostRatingViewOutput {
    func viewIsReady() {
        updateLikeColor()
        updateLikes()
        
        updateDislikeColor()
        updateDislikes()
    }
    
    func likeDidSelect() {
        likeAction(post)
    }
    
    func dislikeDidSelect() {
        dislikeAction(post)
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
