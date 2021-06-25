//

import Foundation
import UIKit

class PostRatingView: UITableViewCell, NibReusable, ViewSetup, ViewMeasuresSetup {
    private var presenter: PostRatingViewOutput?
    
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    
    @IBOutlet weak var likesNumber: UILabel!
    @IBOutlet weak var dislikesNumber: UILabel!
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostRatingViewPresenter else {
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
    
    private func setup(with presenter: PostRatingViewPresenter) {
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

extension PostRatingView: PostRatingViewInput {
    func updateLikes(text: String) {
        likesNumber.text = text
    }
    
    func updateDislikes(text: String) {
        dislikesNumber.text = text
    }
}
