//

import Foundation
import ReactiveSwift

class PostListInteractor {
    private let postProvider: PostProviderProtocol
    private let reactivePostProvider: ReactivePostProviderProtocol
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    private let userProvider: ReactiveUserProviderProtocol
    
    weak var presenter: PostListInteractorOutput?
    
    init(
        postProvider: PostProviderProtocol,
        reactivePostProvider: ReactivePostProviderProtocol,
        cellPresenterFactory: PostCardViewPresenterFactoryProtocol,
        userProvider: ReactiveUserProviderProtocol
    ) {
        self.postProvider = postProvider
        self.reactivePostProvider = reactivePostProvider
        self.cellPresenterFactory = cellPresenterFactory
        self.userProvider = userProvider
    }
}

private extension PostListInteractor {
    func processPosts(posts: [Post]) {
        let cellPresenters = posts.map { cellPresenterFactory.createPostCardViewPresenter(post: $0) }
        
        presenter?.updatePostListCellPresenters(cellPresenters)
    }
    
    func processUser(user: User) {
        presenter?.updateUserInfo(user.name, user.email)
    }
    
    func handleError(_ error: Error) {
        presenter?.handleError(error)
    }
}

extension PostListInteractor: PostListInteractorInput {
    func requestPosts() {
        let beReactive = true
        
        //MARK: - 🐌 Not Reactive
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
        
        //MARK: - 🚀 Reactive
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
    
    func requestUser() {
        var producer = userProvider.getUser()
        producer = producer
            .flatMap(.latest) { user in
                return SignalProducer(value: user)
            }
        
        producer.startWithResult { [weak self] result in
            switch result {
            case .success(let user):
                self?.processUser(user: user)
                
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    func didSelectAddButton() {
        print("PostListInteractor.didSelectAddButton()")
        //presenter?.doSomething()
    }
}
