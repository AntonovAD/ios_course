//

import Foundation
import UIKit

class TableDataSource<V, P>: NSObject, UITableViewDataSource
where
    V:UITableViewCell, V:ViewSetup,
    P:CellPresenter, P:ViewOutput
{
    private let dataProvider: TableDataProvider<P>
    private let cellSetup: (_ cell: inout UITableViewCell, _ presenter: P) -> Void
    
    init(
        dataProvider: TableDataProvider<P>,
        cellSetup: @escaping (_ cell: inout UITableViewCell, _ presenter: P) -> Void = { cell, presenter in
            if let genericCell = cell as? V {
                genericCell.setup(with: presenter)
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
