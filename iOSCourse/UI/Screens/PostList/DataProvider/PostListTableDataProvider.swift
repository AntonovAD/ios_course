//

import Foundation

protocol PostListTableDataProviderProtocol {
    var numberOfSections: Int { get }
    
    func numberOfRows(in section: Int) -> Int
    
    func cellForRow(at indexPath: IndexPath) -> PostCardViewPresenter
}

protocol PostListTableDataProtocol {
    func updateCellPresenters(_ presenters: [PostCardViewPresenter])
}

class PostListTableDataProvider {
    private var presenters: [PostCardViewPresenter] = []
}

extension PostListTableDataProvider: PostListTableDataProtocol {
    func updateCellPresenters(_ presenters: [PostCardViewPresenter]) {
        self.presenters = presenters
    }
}

extension PostListTableDataProvider: PostListTableDataProviderProtocol {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return presenters.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> PostCardViewPresenter {
        return presenters[indexPath.row]
    }
}
