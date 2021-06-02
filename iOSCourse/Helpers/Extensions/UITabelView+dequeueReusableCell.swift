//

import UIKit

extension UITableView {
    func dequeueReusableCell(with presenter: CellPresenter, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: presenter.reusableType.reuseIdentifier, for: indexPath)
    }
    
    func registerReusableCell(_ type: NibReusable.Type) {
        register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
    }
}
