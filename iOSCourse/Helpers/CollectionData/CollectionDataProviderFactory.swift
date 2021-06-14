//

import Foundation

protocol CollectionDataProviderFactoryProtocol {
    associatedtype CollectionItemViewPresenter: CellPresenter
    
    func createDataProvider() -> CollectionDataProvider<CollectionItemViewPresenter>
}

class CollectionDataProviderFactory<P: CellPresenter>: CollectionDataProviderFactoryProtocol {
    typealias CollectionItemViewPresenter = P
    
    func createDataProvider() -> CollectionDataProvider<P> {
        return CollectionDataProvider()
    }
}
