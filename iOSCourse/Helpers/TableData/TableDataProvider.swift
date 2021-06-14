//

import Foundation

// MARK: - Protocols
protocol TableDataProviderProtocol {
    associatedtype TableCellViewPresenter
    
    var numberOfSections: Int { get }
    
    func numberOfRows(in section: Int) -> Int
    
    func cellForRow(at indexPath: IndexPath) -> TableCellViewPresenter
}

protocol TableDataProtocol {
    associatedtype TableCellViewPresenter
    
    func updateCellPresenters(_ presenters: [TableCellViewPresenter])
}

// MARK: - Class
class TableDataProvider<P: CellPresenter> {
    typealias TableCellViewPresenter = P
    
    private var presenters: [P] = []
}

// MARK: - Extensions
extension TableDataProvider: TableDataProtocol {
    func updateCellPresenters(_ presenters: [P]) {
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
    
    func cellForRow(at indexPath: IndexPath) -> P {
        return presenters[indexPath.row]
    }
}
