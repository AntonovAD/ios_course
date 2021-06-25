//

import Foundation


class PostPresenter {
    private var router: RouterProtocol?
    
    private let postTableData: TableDataProtocol
    private let interactor: PostInteractorInput
    
    private var presenters: [CellPresenter] = []
    private var title = "Публикация"
    
    weak var viewController: PostViewControllerInput?
    
    init(
        router: RouterProtocol?,
        postTableData: TableDataProtocol,
        interactor: PostInteractorInput
    ) {
        self.router = router
        self.postTableData = postTableData
        self.interactor = interactor
    }
}

private extension PostPresenter {
    func updateTitle() {
        viewController?.updateTitle(title)
    }
    
    func updatePostListCellPresenters() {
        postTableData.updateCellPresenters(presenters)
        viewController?.reloadTable()
    }
}

extension PostPresenter: PostInteractorOutput {
    func updatePostCellPresenters(_ presenters: [CellPresenter]) {
        self.presenters = presenters
        
        updatePostListCellPresenters()
    }
}

extension PostPresenter: PostViewControllerOutput {
    func viewIsReady() {
        updatePostListCellPresenters()
        updateTitle()
    }
}
