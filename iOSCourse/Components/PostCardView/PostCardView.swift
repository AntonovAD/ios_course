//

import UIKit

class PostCardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initNib()
    }
    
    private func initNib() {
        XIBUtils.initNib(name: "PostCardView", self)
    }

}
