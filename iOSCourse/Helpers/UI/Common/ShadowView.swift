//

import UIKit

@IBDesignable
class ShadowView: UIView {
    
    /// Определяет радиус срезания угла
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateLayer()
        }
    }
    
    /// Определяет, будет ли срезаться правый верхний угол view
    @IBInspectable var topRightCorner: Bool = false {
        didSet {
            updateLayer()
        }
    }
    
    /// Определяет, будет ли срезаться левый верхний угол view
    @IBInspectable var topLeftCorner: Bool = false {
        didSet {
            updateLayer()
        }
    }
    
    /// Определяет, будет ли срезаться правый нижний угол view
    @IBInspectable var bottomRightCorner: Bool = false {
        didSet {
            updateLayer()
        }
    }
    
    /// Определяет, будет ли срезаться левый нижний угол view
    @IBInspectable var bottomLeftCorner: Bool = false {
        didSet {
            updateLayer()
        }
    }
    
    /// Цвет тени
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Double = 0.5 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
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
        
        // Зададим настройки
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = Float(shadowOpacity)
        
        // Обозначим тень
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height:  cornerRadius)
        ).cgPath
    }
    
}
