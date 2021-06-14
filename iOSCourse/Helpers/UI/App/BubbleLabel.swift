//

import Foundation
import UIKit

@IBDesignable
class BubbleLabel: RoundedView {
    
    @IBInspectable var text: String = "Текст" {
        didSet {
            updateLayer()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func updateLayer() {
        setMeasures()
        setLabel()
    }
    
    private func setMeasures() {
        cornerRadius = ViewIndent.normal.rawValue
        backgroundColor = UIColor.appColor(.secondaryFill)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: ViewSize.small.rawValue).isActive = true
    }
    
    private func setLabel() {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = UIFont.systemFont(
            ofSize: FontSize.small.rawValue,
            weight: UIFont.Weight.semibold
        )
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: ViewIndent.normal.rawValue
        ).isActive = true
        label.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: ViewIndent.normal.rawValue
        ).isActive = true
    }
}
