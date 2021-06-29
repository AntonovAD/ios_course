//

import Foundation
import UIKit

class PostTitleView: UITableViewCell, NibReusable, ViewSetup, ViewMeasuresSetup {
    private var presenter: PostTitleViewOutput?
    
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var postTitle: UILabel!
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostTitleViewPresenter else {
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
    
    private func setup(with presenter: PostTitleViewPresenter) {
        setTitle()
        
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
    
    private func setTitle() {
        let normalTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        let largeTitleFont = UIFont(descriptor: normalTitleFont.fontDescriptor.withSymbolicTraits(.traitBold)!, size: normalTitleFont.pointSize)
        postTitle.font = largeTitleFont
        postTitle.numberOfLines = 2
    }
}

extension PostTitleView: PostTitleViewInput {
    func updatePostTitle(text: String) {
        postTitle.text = text
    }
}
