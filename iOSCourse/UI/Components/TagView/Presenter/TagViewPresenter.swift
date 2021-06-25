//

import Foundation

class TagViewPresenter: CellPresenter {
    let reusableType: Reusable.Type = TagView.self
    
    private(set) var tag: PostTag
    
    weak var view: TagViewInput?
    
    init(tag: PostTag) {
        self.tag = tag
    }
}

extension TagViewPresenter: TagViewOutput {
    func viewIsReady() {
        updateName()
    }
}

private extension TagViewPresenter {
    func updateName() {
        view?.updateName(text: tag.name)
    }
}
