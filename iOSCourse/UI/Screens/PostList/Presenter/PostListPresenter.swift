//

import Foundation

class PostListPresenter {
    private var router: RouterProtocol?
    
    private let postListTableData: TableDataProtocol
    private let interactor: PostListInteractorInput
    
    private var presenters: [PostCardViewPresenter] = []
    private var title = "Публикации"
    
    weak var viewController: PostListViewControllerInput?
    
    init(
        router: RouterProtocol?,
        postListTableData: TableDataProtocol,
        interactor: PostListInteractorInput
    ) {
        self.router = router
        self.postListTableData = postListTableData
        self.interactor = interactor
    }
}

private extension PostListPresenter {
    func updateTitle() {
        viewController?.updateTitle(title)
    }
    
    func updatePostListCellPresenters() {
        postListTableData.updateCellPresenters(presenters)
        viewController?.reloadTable()
    }
    
    func navigateToPost(data: Post) {
        let screenData = PostScreenConfiguratorData(
            post: data
        )
        router?.push(.post, mode: .normal, config: (data: screenData, from: .postList))
    }
    
    func presentPost(data: Post) {
        let screenData = PostScreenConfiguratorData(
            post: data
        )
        router?.push(.post, mode: .present, config: (data: screenData, from: .postList))
    }
}

extension PostListPresenter: PostListInteractorOutput {
    func updatePostListCellPresenters(_ presenters: [PostCardViewPresenter]) {
        self.presenters = presenters
        
        updatePostListCellPresenters()
    }
    
    func updateUserInfo(_ name: String, _ email: String) {
        viewController?.updateUserInfo(name, email)
    }
    
    func handleError(_ error: Error) {
        
    }
}

extension PostListPresenter: PostListViewControllerOutput {
    func viewIsReady() {
        updateTitle()
        updatePostListCellPresenters()
        
        interactor.requestPosts()
        interactor.requestUser()
    }
    
    func didSelectCell(with indexPath: IndexPath) {
        guard presenters.indices.contains(indexPath.row) else {
            return
        }
        
        let presenter = presenters[indexPath.row]
        
        print("Post:", presenter.post.title)
        
        navigateToPost(data: presenter.post)
        
        //presenter.doSomething()
        
        //interactor.updatePost(presenter.post)
    }
    
    func didSelectCellSwipeActionRead(with indexPath: IndexPath) {
        guard presenters.indices.contains(indexPath.row) else {
            return
        }
        
        let presenter = presenters[indexPath.row]
        
        presentPost(data: presenter.post)
    }
    
    func didSelectAddButton() {
        interactor.didSelectAddButton()
    }
    
    func refreshPosts() {
        interactor.requestPosts()
    }
}
