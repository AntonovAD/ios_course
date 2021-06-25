//

import Foundation
import UIKit

class PostTextView: UITableViewCell, NibReusable, ViewSetup {
    private var presenter: PostTextViewOutput?
    
    @IBOutlet weak var postText: UILabel!
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? PostTextViewPresenter else {
            return
        }
        
        setup(with: presenter)
    }
    
    private func setup(with presenter: PostTextViewPresenter) {
        self.presenter = presenter
        presenter.view = self
        presenter.viewIsReady()
    }
}

extension PostTextView: PostTextViewInput {
    func updatePostText(text: String) {
        postText.text = text
    }
}
