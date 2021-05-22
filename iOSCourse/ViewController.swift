//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postListItemViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let postCardView = PostCardView()
        XIBUtils.loadNib(owner: postListItemViewContainer, view: postCardView)
    }
}

