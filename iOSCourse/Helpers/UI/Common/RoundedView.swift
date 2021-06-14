//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    /// Определяет радиус срезания угла
    @IBInspectable var cornerRadius: CGFloat = ViewIndent.small.rawValue
    
    /// Определяет, будет ли срезаться правый верхний угол view
    @IBInspectable var topRightCorner: Bool = true {
        didSet {
            updateLayer()
        }
    }
    
    /// Определяет, будет ли срезаться левый верхний угол view
    @IBInspectable var topLeftCorner: Bool = true {
        didSet {
            updateLayer()
        }
    }
    
    /// Определяет, будет ли срезаться правый нижний угол view
    @IBInspectable var bottomRightCorner: Bool = true {
        didSet {
            updateLayer()
        }
    }
    
    /// Определяет, будет ли срезаться левый нижний угол view
    @IBInspectable var bottomLeftCorner: Bool = true {
        didSet {
            updateLayer()
        }
    }
    
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
    
    private var borderLayer: CAShapeLayer?
    
    // MARK: - Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Приватные методы
    
    private func updateLayer() {
        
        // По-уполчанию все углы срезаются
        var corners: UIRectCorner = [
            .topRight,
            .topLeft,
            .bottomRight,
            .bottomLeft
        ]
        
        if !topLeftCorner {
            corners.remove(.topLeft)
        }
        
        if !topRightCorner {
            corners.remove(.topRight)
        }
        
        if !bottomLeftCorner {
            corners.remove(.bottomLeft)
        }
        
        if !bottomRightCorner {
            corners.remove(.bottomRight)
        }
        
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height:  cornerRadius)
        )
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        if borderLayer == nil {
            borderLayer = CAShapeLayer()
            layer.addSublayer(borderLayer!)
        }
        borderLayer?.path = maskLayer.path
        borderLayer?.strokeColor = borderColor.cgColor
        borderLayer?.fillColor = UIColor.clear.cgColor
        borderLayer?.lineWidth = borderWidth
        borderLayer?.frame = bounds
    }
    
}
