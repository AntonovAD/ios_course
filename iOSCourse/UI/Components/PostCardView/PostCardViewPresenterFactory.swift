//

import Foundation

protocol PostCardViewPresenterFactoryProtocol {
    func createPostCardViewPresenter(post: Post) -> PostCardViewPresenter
}

class PostCardViewPresenterFactory: PostCardViewPresenterFactoryProtocol {
    private let tagsCollectionDataProviderFactory: CollectionDataProviderFactoryProtocol
    
    init(tagsCollectionDataProviderFactory: CollectionDataProviderFactoryProtocol) {
        self.tagsCollectionDataProviderFactory = tagsCollectionDataProviderFactory
    }
    
    func createPostCardViewPresenter(post: Post) -> PostCardViewPresenter {
        let tagsCollectionDataProvider = tagsCollectionDataProviderFactory.createDataProvider()
        
        return PostCardViewPresenter(
            post: post,
            tagsCollectionDataProvider: tagsCollectionDataProvider
        )
    }
}
