//

import UIKit

@IBDesignable
class RoundView: UIView {
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            updateLayer()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            updateLayer()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayer()
    }
    
    // MARK: - Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func updateLayer() {
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        
        clipsToBounds = true
    }

}
