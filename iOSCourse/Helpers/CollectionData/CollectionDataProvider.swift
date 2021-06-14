//

import Foundation

// MARK: - Protocols
protocol CollectionDataProviderProtocol {
    associatedtype CollectionItemViewPresenter
    
    var numberOfSections: Int { get }
    
    func numberOfItems(in section: Int) -> Int
    
    func cellForRow(at indexPath: IndexPath) -> CollectionItemViewPresenter
}

protocol CollectionDataProtocol {
    associatedtype CollectionItemViewPresenter
    
    func updateItemPresenters(_ presenters: [CollectionItemViewPresenter])
}

// MARK: - Class
class CollectionDataProvider<P: CellPresenter> {
    typealias CollectionItemViewPresenter = P

    private var presenters: [P] = []
}

// MARK: - Extensions
extension CollectionDataProvider: CollectionDataProtocol {
    func updateItemPresenters(_ presenters: [P]) {
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
    
    func cellForRow(at indexPath: IndexPath) -> P {
        return presenters[indexPath.row]
    }
}
