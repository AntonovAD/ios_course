//

import UIKit

class TagView: UICollectionViewCell, NibReusable, ViewSetup {
    private var presenter: TagViewOutput?
    
    private let customView = BubbleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(customView)
        customView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        customView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        customView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(with presenter: ViewOutput) {
        if let castedPresenter = presenter as? TagViewPresenter {
            self.presenter = castedPresenter
            castedPresenter.view = self
            castedPresenter.viewIsReady()
        }
    }
}

extension TagView: TagViewInput {
    func updateName(text: String) {
        customView.text = text
    }
}
