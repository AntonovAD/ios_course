//

import Foundation

protocol TableDataProviderFactoryProtocol {
    associatedtype TableCellViewPresenter: CellPresenter
    
    func createDataProvider() -> TableDataProvider<TableCellViewPresenter>
}

class TableDataProviderFactory<P: CellPresenter>: TableDataProviderFactoryProtocol {
    typealias TableCellViewPresenter = P
    
    func createDataProvider() -> TableDataProvider<P> {
        return TableDataProvider()
    }
}
