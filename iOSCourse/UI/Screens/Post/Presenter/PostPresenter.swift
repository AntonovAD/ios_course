//

import Foundation


class PostPresenter {
    private var router: RouterProtocol?
    
    private let postTableData: TableDataProtocol
    private let interactor: PostInteractorInput
    
    private var presenters: [CellPresenter] = []
    private let post: Post?
    private let defaultValues = (
        title: "Публикация",
        text: "Кажется, здесь ничего нет"
    )
    
    weak var viewController: PostViewControllerInput?
    
    init(
        router: RouterProtocol?,
        postTableData: TableDataProtocol,
        interactor: PostInteractorInput,
        post: Post?
    ) {
        self.router = router
        self.postTableData = postTableData
        self.interactor = interactor
        self.post = post
    }
}

private extension PostPresenter {
    func updateTitle() {
        viewController?.updateTitle(post?.title ?? defaultValues.title)
    }
    
    func updatePostCellPresenters() {
        postTableData.updateCellPresenters(presenters)
        viewController?.reloadTable()
    }
}

extension PostPresenter: PostInteractorOutput {
    func updatePostCellPresenters(_ presenters: [CellPresenter]) {
        self.presenters = presenters
        
        updatePostCellPresenters()
    }
}

extension PostPresenter: PostViewControllerOutput {
    func viewIsReady() {
        updateTitle()
        updatePostCellPresenters()
        
        if let post = post {
            interactor.prepareTableStructure(post: post)
        }
    }
}
