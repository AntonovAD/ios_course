//

import UIKit

class AuthScreenViewController: UIViewController {
    private var presenter: AuthScreenViewControllerOutput?
    private let queue = DispatchQueue.main
    
    @IBOutlet weak var loginInput: TextFieldInput!
    @IBOutlet weak var passwordInput: TextFieldInput!
    @IBOutlet weak var submitButton: UIButton!
    
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
        queue.async {
            self.navigationItem.title = text
        }
    }
}

private extension AuthScreenViewController {
    @IBAction func didSelectSubmitButton(_ sender: Any) {
        if let login: String = loginInput.text,
            let password: String = passwordInput.text,
            !login.isEmpty,
            !password.isEmpty
        {
            presenter?.didSelectSubmitButton(login: login, password: password)
        } else {
            print("didSelectSubmitButton: invalid inputs")
        }
    }
    
    func setupView() {
        queue.async {
            self.setTitleBar()
        }
    }
    
    func setTitleBar() {
        queue.async {
            self.navigationItem.largeTitleDisplayMode = .automatic
        }
    }
}
