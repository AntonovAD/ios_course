//

import Foundation

class PostTagsCollectionViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = PostTagsCollectionView.self
    
    private(set) var post: Post
    private(set) var tagsCollectionDataProvider: CollectionDataProvider
    private(set) var tagsPresenters: [TagViewPresenter]
        
    weak var view: PostTagsCollectionViewInput?
    
    init(
        post: Post,
        tagsCollectionDataProvider: CollectionDataProvider
    ) {
        self.post = post
        self.tagsCollectionDataProvider = tagsCollectionDataProvider
        self.tagsPresenters = post.tags.map { TagViewPresenter(tag: $0) }
    }
}

extension PostTagsCollectionViewPresenter: PostTagsCollectionViewOutput {
    func viewIsReady() {
        updateTags()
    }
}

private extension PostTagsCollectionViewPresenter {
    func updateTags() {
        tagsCollectionDataProvider.updateItemPresenters(tagsPresenters)
        view?.reloadTags()
    }
}
