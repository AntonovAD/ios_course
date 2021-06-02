//

import UIKit

class PostCardView: UITableViewCell, NibReusable {
    private var presenter: PostCardViewOutput?
    
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    
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
    
}
