//

import Foundation
import UIKit

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var itemSpacing: CGFloat
    var didSelectItem: (IndexPath) -> Void
    
    init(
        itemSpacing: CGFloat = ViewIndent.normal.rawValue,
        didSelectItem: @escaping (IndexPath) -> Void
    ) {
        self.itemSpacing = itemSpacing
        self.didSelectItem = didSelectItem
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(indexPath)
    }
}

extension CollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
}
