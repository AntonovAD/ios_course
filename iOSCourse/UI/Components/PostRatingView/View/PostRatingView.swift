//

import Foundation
import UIKit

class PostRatingView: UITableViewCell, NibReusable, ViewSetup {
    private var presenter: PostRatingViewOutput?
    @IBOutlet weak var likesNumber: UILabel!
    @IBOutlet weak var dislikesNumber: UILabel!
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostRatingViewPresenter else {
            return
        }
        
        setup(with: presenter)
    }
    
    private func setup(with presenter: PostRatingViewPresenter) {
        self.presenter = presenter
        presenter.view = self
        presenter.viewIsReady()
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
