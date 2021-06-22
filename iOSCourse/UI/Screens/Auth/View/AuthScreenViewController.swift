//

import UIKit

class AuthScreenViewController: UIViewController {
    private var presenter: AuthScreenViewControllerOutput?
    
    convenience init(
        presenter: AuthScreenViewControllerOutput
    ) {
        self.init()
        
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        presenter?.viewIsReady()
    }
}

extension AuthScreenViewController: AuthScreenViewControllerInput {
    func updateTitle(_ text: String) {
        navigationItem.title = text
    }
}

private extension AuthScreenViewController {
    func setupView() {
        setTitleBar()
    }
    
    func setTitleBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
