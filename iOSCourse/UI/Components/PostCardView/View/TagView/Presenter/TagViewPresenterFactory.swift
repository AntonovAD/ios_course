//

import Foundation

protocol TagViewPresenterFactoryProtocol {
    func createTagViewPresenter(tag: PostTag) -> TagViewPresenter
}

class nameTagViewPresenterFactory: TagViewPresenterFactoryProtocol {
    func createTagViewPresenter(tag: PostTag) -> TagViewPresenter {
        return TagViewPresenter(tag: tag)
    }
}
