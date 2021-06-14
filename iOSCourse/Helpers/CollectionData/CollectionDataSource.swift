//

import Foundation
import UIKit

class CollectionDataSource<V, P>: NSObject, UICollectionViewDataSource
where
    V:UICollectionViewCell, V:ViewSetup,
    P:CellPresenter, P:ViewOutput
{
    private let dataProvider: CollectionDataProvider<P>
    private let cellSetup: (_ cell: inout UICollectionViewCell, _ presenter: P) -> Void
    
    init(
        dataProvider: CollectionDataProvider<P>,
        cellSetup: @escaping (_ cell: inout UICollectionViewCell, _ presenter: P) -> Void = { cell, presenter in
            if let genericCell = cell as? V {
                genericCell.setup(with: presenter)
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
