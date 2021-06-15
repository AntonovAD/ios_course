//

import Foundation

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
        view?.updateLikes(like: post.likes, dislike: post.dislikes)
    }
    
    func updateTags() {
        tagsCollectionDataProvider.updateItemPresenters(tagsPresenters)
        view?.reloadTags()
    }
}
