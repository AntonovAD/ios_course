//

import UIKit

@IBDesignable
class TextFieldInput: UITextField {
    
    // MARK: - Measures
    
    private var overrideHeight: CGFloat = CGFloat(ViewSize.normal.rawValue) {
        didSet {
            updateLayer()
        }
    }
    
    @IBInspectable var topPadding: CGFloat = CGFloat(ViewIndent.normal.rawValue)

    @IBInspectable var bottomPadding: CGFloat = CGFloat(ViewIndent.normal.rawValue)

    @IBInspectable var leftPadding: CGFloat = CGFloat(ViewIndent.normal.rawValue)

    @IBInspectable var rightPadding: CGFloat = CGFloat(ViewIndent.normal.rawValue)
    
    private var padding: UIEdgeInsets {
        get {
            return UIEdgeInsets(
                top: topPadding,
                left: leftPadding,
                bottom: bottomPadding,
                right: rightPadding
            )
        }
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Border
    
    private var cornerRadius: CGFloat = CGFloat(ViewIndent.normal.rawValue) {
        didSet {
            updateLayer()
        }
    }
    
    private var borderWidth: CGFloat = 0 {
        didSet {
            updateLayer()
        }
    }
    
    private var borderColor: UIColor = UIColor.appColor(.secondaryFill) ?? .clear {
        didSet {
            updateLayer()
        }
    }
    
    private var borderLayer: CAShapeLayer?
    
    // MARK: - Background
    
    @IBInspectable var fillColor: UIColor = UIColor.appColor(.secondaryFill) ?? .clear {
        didSet {
            updateLayer()
        }
    }
    
    // MARK: - Text
    
    private var overrideTextFont: UIFont = UIFont.systemFont(
        ofSize: CGFloat(FontSize.small.rawValue),
        weight: UIFont.Weight.semibold
    )
    
    private var defaultPlaceholderText: String = "Введите значение..."
    
    @IBInspectable var placeholderFontColor: UIColor = .lightGray {
        didSet {
            updateLayer()
        }
    }
    
    // MARK: - Redraw()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayer()
    }
    
    // MARK: - Init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Func()
    
    private func updateLayer() {
        setMeasures()
        setBorder()
        setBackground()
        setFont()
    }
    
    private func setMeasures() {
        frame.size.height = overrideHeight
    }
    
    private func setBorder() {
        borderStyle = .none
        
        let corners: UIRectCorner = [
            .topRight,
            .topLeft,
            .bottomRight,
            .bottomLeft
        ]
        
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
    
    private func setBackground() {
        backgroundColor = fillColor
    }
    
    private func setFont() {
        font = overrideTextFont
        
        if placeholder == nil {
            placeholder = defaultPlaceholderText
        }
        
        let placeholderString = NSAttributedString.init(
            string: placeholder ?? defaultPlaceholderText,
            attributes: [
                NSAttributedString.Key.foregroundColor: placeholderFontColor,
                NSAttributedString.Key.font: overrideTextFont
            ]
        )
        attributedPlaceholder = placeholderString
    }
}
