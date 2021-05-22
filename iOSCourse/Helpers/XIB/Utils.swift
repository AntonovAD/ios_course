//

import UIKit

class XIBUtils {
    static func initNib(name: String, _ owner: UIView) -> Void {
        let nib = UINib(nibName: name, bundle: .main)
        let views = nib.instantiate(withOwner: owner, options: nil).compactMap { $0 as? UIView }
        
        for view in views {
            loadNib(owner: owner, view: view)
        }
    }
    
    static func loadNib(owner: UIView, view: UIView) -> Void {
        owner.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.leadingAnchor.constraint(equalTo: owner.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: owner.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: owner.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: owner.bottomAnchor).isActive = true
    }
}
