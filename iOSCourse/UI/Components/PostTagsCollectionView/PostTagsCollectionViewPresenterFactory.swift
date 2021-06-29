//

import Foundation

protocol PostTagsCollectionViewPresenterFactoryProtocol {
    func createPostTagsCollectionViewPresenter(post: Post) -> PostTagsCollectionViewPresenter
}

class PostTagsCollectionViewPresenterFactory: PostTagsCollectionViewPresenterFactoryProtocol {
    private let tagsCollectionDataProviderFactory: CollectionDataProviderFactoryProtocol
    
    init(tagsCollectionDataProviderFactory: CollectionDataProviderFactoryProtocol) {
        self.tagsCollectionDataProviderFactory = tagsCollectionDataProviderFactory
    }
    
    func createPostTagsCollectionViewPresenter(post: Post) -> PostTagsCollectionViewPresenter {
        let tagsCollectionDataProvider = tagsCollectionDataProviderFactory.createDataProvider()
        
        return PostTagsCollectionViewPresenter(
            post: post,
            tagsCollectionDataProvider: tagsCollectionDataProvider
        )
    }
}
