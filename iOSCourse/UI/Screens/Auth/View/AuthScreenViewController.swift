//

import UIKit

class AuthScreenViewController: UIViewController {
    private var presenter: AuthScreenViewControllerOutput?
    private let queue = DispatchQueue.main
    
    @IBOutlet weak var appTitle: UILabel!
    
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
    
    func errorPulseAppTitle() {
        queue.async {
            CATransaction.begin()
            
            let initialTextColor = self.appTitle.textColor
            
            self.appTitle.textColor = .red
            
            let pulseAnimation = CABasicAnimation(keyPath: "opacity")
            pulseAnimation.duration = 0.1
            pulseAnimation.fromValue = 0
            pulseAnimation.toValue = 1
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = 4
            
            CATransaction.setCompletionBlock{ [weak self] in
                self?.appTitle.textColor = initialTextColor
            }
            
            self.appTitle.layer.add(pulseAnimation, forKey: nil)
            CATransaction.commit()
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
