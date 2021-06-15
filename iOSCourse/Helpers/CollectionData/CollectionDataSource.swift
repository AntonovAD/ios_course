//

import Foundation
import UIKit

class CollectionDataSource: NSObject, UICollectionViewDataSource {
    private let dataProvider: CollectionDataProviderProtocol
    private let cellSetup: (inout UICollectionViewCell, CellPresenter) -> Void
    
    init(
        dataProvider: CollectionDataProviderProtocol,
        cellSetup: @escaping (inout UICollectionViewCell, CellPresenter) -> Void = { cell, presenter in
            if let cell = cell as? ViewSetup {
                cell.setup(with: presenter)
            }
        }
    ) {
        self.dataProvider = dataProvider
        self.cellSetup = cellSetup
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let presenter = dataProvider.cellForRow(at: indexPath)
        
        var cell = collectionView.dequeueReusableCell(with: presenter, for: indexPath)
        
        cellSetup(&cell, presenter)
        
        return cell
    }
}
