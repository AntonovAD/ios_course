//

import Foundation
import UIKit

class TableDataSource: NSObject, UITableViewDataSource {
    private let dataProvider: TableDataProviderProtocol
    private let cellSetup: (inout UITableViewCell, CellPresenter) -> Void
    
    init(
        dataProvider: TableDataProviderProtocol,
        cellSetup: @escaping (inout UITableViewCell, CellPresenter) -> Void = { cell, presenter in
            if let cell = cell as? ViewSetup {
                cell.setup(with: presenter)
            }
        }
    ) {
        self.dataProvider = dataProvider
        self.cellSetup = cellSetup
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let presenter = dataProvider.cellForRow(at: indexPath)
        
        var cell = tableView.dequeueReusableCell(with: presenter, for: indexPath)
        
        cellSetup(&cell, presenter)
        
        return cell
    }
}
