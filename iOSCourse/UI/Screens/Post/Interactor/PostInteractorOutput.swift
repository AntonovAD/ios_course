//

import Foundation

protocol PostInteractorOutput: AnyObject {
    func updatePostCellPresenters(_ presenters: [CellPresenter])
}
