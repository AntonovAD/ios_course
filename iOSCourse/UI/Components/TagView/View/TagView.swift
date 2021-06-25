//

import UIKit

class TagView: UICollectionViewCell, Reusable, ViewSetup {
    private var presenter: TagViewOutput?
    
    private let customView = BubbleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        customView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        customView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(with presenter: CellPresenter) {
        guard let presenter = presenter as? TagViewPresenter else {
            return
        }
        
        setup(with: presenter)
    }
    
    private func setup(with presenter: TagViewPresenter) {
        self.presenter = presenter
        presenter.view = self
        presenter.viewIsReady()
    }
}

extension TagView: TagViewInput {
    func updateName(text: String) {
        customView.text = text
    }
}
