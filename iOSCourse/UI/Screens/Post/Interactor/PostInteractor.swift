//

import Foundation

class PostInteractor {
    private let postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol
    private let postTextPresenterFactory: PostTextViewPresenterFactoryProtocol
    private let postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    
    weak var presenter: PostInteractorOutput?
    
    init(
        postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol,
        postTextPresenterFactory: PostTextViewPresenterFactoryProtocol,
        postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    ) {
        self.postInfoPresenterFactory = postInfoPresenterFactory
        self.postTextPresenterFactory = postTextPresenterFactory
        self.postRatingPresenterFactory = postRatingPresenterFactory
    }
}

private extension PostInteractor {
    func processPost(post: Post) {
        let postInfoPresenter = postInfoPresenterFactory.createPostInfoViewPresenter(post: post)
        let postTextPresenter = postTextPresenterFactory.createPostTextViewPresenter(post: post)
        let postRatingPresenter = postRatingPresenterFactory.createPostRatingViewPresenter(post: post)
        
        let cellPresenters: [CellPresenter] = [
            postInfoPresenter,
            postTextPresenter,
            postRatingPresenter
        ]
        
        presenter?.updatePostCellPresenters(cellPresenters)
    }
}

extension PostInteractor: PostInteractorInput {
    func prepareTableStructure(post: Post) {
        processPost(post: post)
    }
}
