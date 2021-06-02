//

import Foundation

class PostListInteractor {
    private let postProvider: PostProviderProtocol
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    
    weak var presenter: PostListInteractorOutput?
    
    init(postProvider: PostProviderProtocol, cellPresenterFactory: PostCardViewPresenterFactoryProtocol) {
        self.postProvider = postProvider
        self.cellPresenterFactory = cellPresenterFactory
    }
}

private extension PostListInteractor {
    func processPosts(posts: [Post]) {
        let cellPresenters = posts.map { cellPresenterFactory.createPostCardViewPresenter(post: $0) }
        
        presenter?.updateCellPresenters(cellPresenters)
    }
    
    func handleError(_ error: Error) {
        presenter?.handleError(error)
    }
}

extension PostListInteractor: PostListInteractorInput {
    func requestPosts() {
        postProvider.requestAll { [weak self] result in
            switch result {
            case .success(let posts):
                self?.processPosts(posts: posts)
                
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
}
