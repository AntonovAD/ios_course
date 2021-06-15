//

import Foundation

protocol CollectionDataProviderFactoryProtocol {
    func createDataProvider() -> CollectionDataProvider
}

class CollectionDataProviderFactory: CollectionDataProviderFactoryProtocol {
    func createDataProvider() -> CollectionDataProvider {
        return CollectionDataProvider()
    }
}
