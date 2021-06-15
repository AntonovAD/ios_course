//

import Foundation

// MARK: - Protocols
protocol CollectionDataProviderProtocol {
    var numberOfSections: Int { get }
    
    func numberOfItems(in section: Int) -> Int
    
    func cellForRow(at indexPath: IndexPath) -> CellPresenter
}

protocol CollectionDataProtocol {
    func updateItemPresenters(_ presenters: [CellPresenter])
}

// MARK: - Class
class CollectionDataProvider {
    private var presenters: [CellPresenter] = []
}

// MARK: - Extensions
extension CollectionDataProvider: CollectionDataProtocol {
    func updateItemPresenters(_ presenters: [CellPresenter]) {
        self.presenters = presenters
    }
}

extension CollectionDataProvider: CollectionDataProviderProtocol {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return presenters.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CellPresenter {
        return presenters[indexPath.row]
    }
}
