//

import Foundation
import UIKit

class PostInfoView: UITableViewCell, NibReusable, ViewSetup {
    private var presenter: PostInfoViewOutput?
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostInfoViewPresenter else {
            return
        }
        
        setup(with: presenter)
    }
    
    private func setup(with presenter: PostInfoViewPresenter) {
        self.presenter = presenter
        presenter.view = self
        presenter.viewIsReady()
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
