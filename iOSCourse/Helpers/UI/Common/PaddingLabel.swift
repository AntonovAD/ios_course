//

import UIKit

@IBDesignable
class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = ViewIndent.small.rawValue
    @IBInspectable var bottomInset: CGFloat = ViewIndent.small.rawValue
    @IBInspectable var leftInset: CGFloat = ViewIndent.large.rawValue
    @IBInspectable var rightInset: CGFloat = ViewIndent.large.rawValue

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + leftInset + rightInset,
            height: size.height + topInset + bottomInset
        )
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
