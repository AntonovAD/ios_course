//

import Foundation

protocol CellPresenter: ViewOutput {
    var reusableType: Reusable.Type { get }
}
