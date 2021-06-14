//

import Foundation
import ReactiveSwift

class PostListInteractor {
    private let postProvider: PostProviderProtocol
    private let reactivePostProvider: ReactivePostProviderProtocol
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    
    weak var presenter: PostListInteractorOutput?
    
    init(
        postProvider: PostProviderProtocol,
        reactivePostProvider: ReactivePostProviderProtocol,
        cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    ) {
        self.postProvider = postProvider
        self.reactivePostProvider = reactivePostProvider
        self.cellPresenterFactory = cellPresenterFactory
    }
}

private extension PostListInteractor {
    func processPosts(posts: [Post]) {
        let cellPresenters = posts.map { cellPresenterFactory.createPostCardViewPresenter(post: $0) }
        
        presenter?.updatePostListCellPresenters(cellPresenters)
    }
    
    func handleError(_ error: Error) {
        presenter?.handleError(error)
    }
}

extension PostListInteractor: PostListInteractorInput {
    func requestPosts() {
        let beReactive = true
        
        // 🐌 Not Reactive
        if (!beReactive) {
            postProvider.requestAll { [weak self] result in
                switch result {
                case .success(let posts):
                    self?.processPosts(posts: posts)
                    
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
        
        // 🚀 Reactive
        if (beReactive) {
            var producer = reactivePostProvider.requestAll()
            producer = producer
                .flatMap(.latest) { posts in
                    return SignalProducer(value: posts)
                }
            
            producer.startWithResult { [weak self] result in
                switch result {
                case .success(let posts):
                    self?.processPosts(posts: posts)
                    
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }
}
