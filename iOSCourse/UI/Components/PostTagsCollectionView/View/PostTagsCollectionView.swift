//

import Foundation
import UIKit

class PostTagsCollectionView: UITableViewCell, NibReusable, ViewSetup, ViewMeasuresSetup {
    private var presenter: PostTagsCollectionViewOutput?
    
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var tagsCollectionViewFlowLayout: UICollectionViewFlowLayout!
    private var tagsCollectionData: (
        source: CollectionDataSource?,
        delegate: CollectionViewDelegate?
    )
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostTagsCollectionViewPresenter else {
            return
        }
        
        setup(with: presenter)
    }
    
    func setup(
        with presenter: CellPresenter,
        margin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    ) {
        setMeasures(margin: margin)
        
        setup(with: presenter)
    }
    
    private func setup(with presenter: PostTagsCollectionViewPresenter) {
        setTagsData(with: presenter.tagsCollectionDataProvider)
        
        self.presenter = presenter
        presenter.view = self
        presenter.viewIsReady()
    }
    
    private func setMeasures(margin: UIEdgeInsets) {
        topMargin.constant = margin.top
        rightMargin.constant = margin.right
        bottomMargin.constant = margin.bottom
        leftMargin.constant = margin.left
    }
    
    private func setTagsData(with provider: CollectionDataProvider) {
        tagsCollectionData = (
            source: CollectionDataSource(
                dataProvider: provider
            ),
            delegate: CollectionViewDelegate(
                itemSpacing: ViewIndent.normal.rawValue,
                didSelectItem: { _ in return }
            )
        )
        
        tagsCollectionView.register(TagView.self, forCellWithReuseIdentifier: TagView.reuseIdentifier)
        
        tagsCollectionView.dataSource = tagsCollectionData.source
        tagsCollectionView.delegate = tagsCollectionData.delegate
        
        tagsCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
}

extension PostTagsCollectionView: PostTagsCollectionViewInput {
    func reloadTags() {
        tagsCollectionView.reloadData()
    }    
}
