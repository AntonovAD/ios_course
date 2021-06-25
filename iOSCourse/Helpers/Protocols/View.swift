//

import Foundation
import UIKit

protocol ViewOutput {
    func viewIsReady()
}

protocol ViewSetup {
    func setup(with presenter: CellPresenter)
}

protocol ViewMeasuresSetup {
    var topMargin: NSLayoutConstraint! { get set }
    var leftMargin: NSLayoutConstraint! { get set }
    var bottomMargin: NSLayoutConstraint! { get set }
    var rightMargin: NSLayoutConstraint! { get set }
    
    func setup(
        with presenter: CellPresenter,
        margin: UIEdgeInsets
    )
}
