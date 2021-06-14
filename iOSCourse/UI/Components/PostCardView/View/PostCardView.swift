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
        source: CollectionDataSource<TagView, TagViewPresenter>?,
        delegate: CollectionViewDelegate?
    )
    
    func setup(with presenter: ViewOutput) {
        if let castedPresenter = presenter as? PostCardViewPresenter {
            self.presenter = castedPresenter
            castedPresenter.view = self
            castedPresenter.viewIsReady()
        }
    }
    
    func setup(
        with presenter: PostCardViewPresenter,
        margin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    ) {
        self.presenter = presenter
        
        topMargin.constant = margin.top
        rightMargin.constant = margin.right
        bottomMargin.constant = margin.bottom
        leftMargin.constant = margin.left
        
        presenter.view = self
        
        presenter.viewIsReady()
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
