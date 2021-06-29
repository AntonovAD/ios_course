//

import Foundation
import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    var didSelectRow: (IndexPath) -> Void
    var leadingSwipeActions: (IndexPath) -> [UIContextualAction]
    var trailingSwipeActions: (IndexPath) -> [UIContextualAction]
    
    init(
        leadingSwipeActions: ((IndexPath) -> [UIContextualAction])? = { _ in return [] },
        trailingSwipeActions: ((IndexPath) -> [UIContextualAction])? = { _ in return [] },
        didSelectRow: ((IndexPath) -> Void)? = { _ in return }
    ) {
        self.didSelectRow = didSelectRow ?? { _ in return }
        self.leadingSwipeActions = leadingSwipeActions ?? { _ in return [] }
        self.trailingSwipeActions = trailingSwipeActions ?? { _ in return [] }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: leadingSwipeActions(indexPath))
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: trailingSwipeActions(indexPath))
    }
}
