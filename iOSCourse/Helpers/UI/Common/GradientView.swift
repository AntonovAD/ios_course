//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0) {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1.0, y: 0.0) {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var startColor: UIColor? = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var endColor: UIColor? = UIColor.black {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }

    private func setupView() {
        guard
            let startColor = startColor,
            let endColor = endColor,
            let layer = layer as? CAGradientLayer
            else
        {
            return
        }
        
        layer.colors = [startColor.cgColor, endColor.cgColor]
        layer.cornerRadius = cornerRadius
        
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        
        setNeedsDisplay()
    }
    
    // MARK: - Overrides
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?
    ) {
        super.traitCollectionDidChange(previousTraitCollection)

        setupView()
    }
}
