//

import UIKit

extension UICollectionView {
    func dequeueReusableCell(with presenter: CellPresenter, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: presenter.reusableType.reuseIdentifier, for: indexPath)
    }
    
    func registerReusableCell(_ type: NibReusable.Type) {
        register(type.nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
}
