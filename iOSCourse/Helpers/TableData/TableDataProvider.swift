//

import Foundation

// MARK: - Protocols
protocol TableDataProviderProtocol {
    var numberOfSections: Int { get }
    
    func numberOfRows(in section: Int) -> Int
    
    func cellForRow(at indexPath: IndexPath) -> CellPresenter
}

protocol TableDataProtocol {
    func updateCellPresenters(_ presenters: [CellPresenter])
}

// MARK: - Class
class TableDataProvider {
    private var presenters: [CellPresenter] = []
}

// MARK: - Extensions
extension TableDataProvider: TableDataProtocol {
    func updateCellPresenters(_ presenters: [CellPresenter]) {
        self.presenters = presenters
    }
}

extension TableDataProvider: TableDataProviderProtocol {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return presenters.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CellPresenter {
        return presenters[indexPath.row]
    }
}
