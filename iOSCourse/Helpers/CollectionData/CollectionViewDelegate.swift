//

import Foundation
import UIKit

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var didSelectItem: (IndexPath) -> Void
    
    init(didSelectItem: @escaping (IndexPath) -> Void) {
        self.didSelectItem = didSelectItem
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(indexPath)
    }
}
