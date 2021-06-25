//

import Foundation
import UIKit

class PostInfoView: UITableViewCell, NibReusable, ViewSetup, ViewMeasuresSetup {
    private var presenter: PostInfoViewOutput?
    
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostInfoViewPresenter else {
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
    
    private func setup(with presenter: PostInfoViewPresenter) {
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
}

extension PostInfoView: PostInfoViewInput {
    func updateAuthorName(text: String) {
        authorName.text = text
    }
    
    func updatePostDate(text: String) {
        postDate.text = text
    }
}
