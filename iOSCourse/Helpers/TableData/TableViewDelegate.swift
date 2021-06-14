//

import Foundation
import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    var didSelectRow: (IndexPath) -> Void
    
    init(didSelectRow: @escaping (IndexPath) -> Void) {
        self.didSelectRow = didSelectRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(indexPath)
    }
}
