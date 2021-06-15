//

import Foundation

protocol TableDataProviderFactoryProtocol {
    func createDataProvider() -> TableDataProvider
}

class TableDataProviderFactory: TableDataProviderFactoryProtocol {
    func createDataProvider() -> TableDataProvider {
        return TableDataProvider()
    }
}
