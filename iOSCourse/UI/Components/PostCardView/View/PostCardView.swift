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
    private var tagsCollectionData: (
        source: CollectionDataSource?,
        delegate: CollectionViewDelegate?
    )
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostCardViewPresenter else {
            return
        }
        
        self.presenter = presenter
        presenter.view = self
        presenter.viewIsReady()
    }
    
    func setup(
        with presenter: CellPresenter,
        margin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    ) {
        setMeasures(margin: margin)
        
        setup(with: presenter)
    }
    
    private func setMeasures(margin: UIEdgeInsets) {
        topMargin.constant = margin.top
        rightMargin.constant = margin.right
        bottomMargin.constant = margin.bottom
        leftMargin.constant = margin.left
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
    
    func updateTags(tags: [String]) {
        //TODO updateTags
    }
}

private extension PostCardView {
    func didSelectTag(at indexPath: IndexPath) {
        //TODO didSelectTag
        //presenter?.didSelectCell(with: indexPath)
    }
}
