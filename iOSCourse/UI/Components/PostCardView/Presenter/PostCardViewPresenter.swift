//

import Foundation
import UIKit

class PostCardViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = PostCardView.self
    
    private(set) var post: Post
    private(set) var tagsCollectionDataProvider: CollectionDataProvider
    private(set) var tagsPresenters: [TagViewPresenter]
    
    weak var view: PostCardViewInput?
    
    init(
        post: Post,
        tagsCollectionDataProvider: CollectionDataProvider
    ) {
        self.post = post
        self.tagsCollectionDataProvider = tagsCollectionDataProvider
        self.tagsPresenters = post.tags.map { TagViewPresenter(tag: $0) }
    }
}

extension PostCardViewPresenter: PostCardViewOutput {
    func viewIsReady() {
        updateTitle()
        updateAuthor()
        updateDate()
        updateLikes()
        updateDislikes()
        updateTags()
    }
    
    func didSelectTag(with indexPath: IndexPath) {
        guard tagsPresenters.indices.contains(indexPath.row) else {
            return
        }
        
        let tagPresenter = tagsPresenters[indexPath.row]
        
        print("Tag:", tagPresenter.tag.name)
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
        let yourLike = post.your_likes > 0
        
        view?.updateLikeColor(
            backgroundColor: yourLike
                ? .systemGreen
                : UIColor.appColor(.secondaryFill) ?? .clear,
            textColor: yourLike
                ? .white
                : .lightGray
        )
        
        view?.updateLikes(text: "\(post.likes)")
    }
    
    func updateDislikes() {
        let yourDislike = post.your_dislikes > 0
        
        view?.updateDislikeColor(
            backgroundColor: yourDislike
                ? .systemRed
                : UIColor.appColor(.secondaryFill) ?? .clear,
            textColor: yourDislike
                ? .white
                : .lightGray
        )
        
        view?.updateDislikes(text: "\(post.dislikes)")
    }
    
    func updateTags() {
        tagsCollectionDataProvider.updateItemPresenters(tagsPresenters)
        view?.reloadTags()
    }
}
