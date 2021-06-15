//

import UIKit

class PostCardView: UITableViewCell, NibReusable, ViewSetup {
    private var presenter: PostCardViewOutput?
    
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var dislike: UILabel!
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var tagsCollectionViewFlowLayout: UICollectionViewFlowLayout!
    private var tagsCollectionData: (
        source: CollectionDataSource?,
        delegate: CollectionViewDelegate?
    )
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostCardViewPresenter else {
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
    
    private func setup(with presenter: PostCardViewPresenter) {
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
                didSelectItem: didSelectTag(at:)
            )
        )
        
        tagsCollectionView.register(TagView.self, forCellWithReuseIdentifier: TagView.reuseIdentifier)
        
        tagsCollectionView.dataSource = tagsCollectionData.source
        tagsCollectionView.delegate = tagsCollectionData.delegate
        
        tagsCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
}

extension PostCardView: PostCardViewInput {
    func updateTitle(text: String) {
        title.text = text
    }
    
    func updateAuthor(text: String) {
        author.text = text
    }
    
    func updateDate(text: String) {
        date.text = text
    }
    
    func updateLikes(like: Int, dislike: Int) {
        self.like.text = String(like)
        self.dislike.text = "\(dislike)"
    }
    
    func reloadTags() {
        self.tagsCollectionView.reloadData()
    }
}

private extension PostCardView {
    func didSelectTag(at indexPath: IndexPath) {
        presenter?.didSelectTag(with: indexPath)
    }
}
