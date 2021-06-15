//

import Foundation
import UIKit

@IBDesignable
class BubbleLabel: RoundedView {
    private let labelView = PaddingLabel()
    
    @IBInspectable var text: String = "Текст" {
        didSet {
            updateLayer()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initLayer() {
        initLabel()
    }
    
    private func initLabel() {
        addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        labelView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    // MARK: - Update
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayer()
    }
    
    private func updateLayer() {
        setMeasures()
        setLabel()
    }
    
    private func setMeasures() {
        cornerRadius = ViewIndent.large.rawValue
        backgroundColor = UIColor.appColor(.secondaryFill)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLabel() {
        labelView.text = text
        labelView.textColor = .lightGray
        labelView.font = UIFont.systemFont(
            ofSize: FontSize.small.rawValue,
            weight: UIFont.Weight.semibold
        )
    }
}
