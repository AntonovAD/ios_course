//

import Foundation
import UIKit

class PostRatingView: UITableViewCell, NibReusable, ViewSetup, ViewMeasuresSetup {
    private var presenter: PostRatingViewOutput?
    
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    
    @IBOutlet weak var likeRoundedView: RoundedView!
    @IBOutlet weak var likesNumber: UILabel!
    
    @IBOutlet weak var dislikeRoundedView: RoundedView!
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
}

private extension PostRatingView {
    func setup(with presenter: PostRatingViewPresenter) {
        setOnClickListeners()
        
        self.presenter = presenter
        presenter.view = self
        presenter.viewIsReady()
    }
    
    func setMeasures(margin: UIEdgeInsets) {
        topMargin.constant = margin.top
        rightMargin.constant = margin.right
        bottomMargin.constant = margin.bottom
        leftMargin.constant = margin.left
    }
    
    func setOnClickListeners() {
        likeRoundedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.likeRoundedViewDidSelect (_:))))
        dislikeRoundedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.dislikeRoundedViewDidSelect (_:))))
    }
    
    @objc
    func likeRoundedViewDidSelect(_ sender:UITapGestureRecognizer) {
        presenter?.likeDidSelect()
    }
    
    @objc
    func dislikeRoundedViewDidSelect(_ sender:UITapGestureRecognizer) {
        presenter?.dislikeDidSelect()
    }
}

extension PostRatingView: PostRatingViewInput {
    func updateLikeColor(backgroundColor: UIColor, textColor: UIColor) {
        likeRoundedView.backgroundColor = backgroundColor
        likesNumber.textColor = textColor
    }
    
    func updateLikes(text: String) {
        likesNumber.text = text
    }
    
    func updateDislikeColor(backgroundColor: UIColor, textColor: UIColor) {
        dislikeRoundedView.backgroundColor = backgroundColor
        dislikesNumber.textColor = textColor
    }
    
    func updateDislikes(text: String) {
        dislikesNumber.text = text
    }
}
