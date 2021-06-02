//

import Foundation

class PostListPresenter {
    private let tableData: PostListTableDataProtocol
    private let interactor: PostListInteractorInput
    
    private var presenters: [PostCardViewPresenter] = []
    private var title = "Публикации"
    
    weak var viewController: PostListViewControllerInput?
    
    init(tableData: PostListTableDataProtocol, interactor: PostListInteractorInput) {
        self.tableData = tableData
        self.interactor = interactor
        
        interactor.requestPosts()
    }
}

private extension PostListPresenter {
    func updateTitle() {
        viewController?.updateTitle(title)
    }
    
    func updateCellPresenters() {
        tableData.updateCellPresenters(presenters)
        viewController?.reloadTable()
    }
}

extension PostListPresenter: PostListInteractorOutput {
    func updateCellPresenters(_ presenters: [PostCardViewPresenter]) {
        self.presenters = presenters
        
        updateCellPresenters()
    }
    
    func handleError(_ error: Error) {
        
    }
}

extension PostListPresenter: PostListViewControllerOutput {
    func viewIsReady() {
        updateCellPresenters()
        updateTitle()
    }
    
    func didSelectCell(with indexPath: IndexPath) {
        guard presenters.indices.contains(indexPath.row) else {
            return
        }
        
        let presenter = presenters[indexPath.row]
        
        print(presenter.post)
        
        //presenter.doSomething()
        
        //interactor.updatePost(presenter.post)
    }
}
