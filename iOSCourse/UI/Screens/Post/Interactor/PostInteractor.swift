//

import Foundation

class PostInteractor {
    private let postTitlePresenterFactory: PostTitleViewPresenterFactoryProtocol
    private let postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol
    private let postTextPresenterFactory: PostTextViewPresenterFactoryProtocol
    private let postTagsCollectionPresenterFactory: PostTagsCollectionViewPresenterFactoryProtocol
    private let postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    
    weak var presenter: PostInteractorOutput?
    
    init(
        postTitlePresenterFactory: PostTitleViewPresenterFactoryProtocol,
        postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol,
        postTextPresenterFactory: PostTextViewPresenterFactoryProtocol,
        postTagsCollectionPresenterFactory: PostTagsCollectionViewPresenterFactoryProtocol,
        postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    ) {
        self.postTitlePresenterFactory = postTitlePresenterFactory
        self.postInfoPresenterFactory = postInfoPresenterFactory
        self.postTextPresenterFactory = postTextPresenterFactory
        self.postTagsCollectionPresenterFactory = postTagsCollectionPresenterFactory
        self.postRatingPresenterFactory = postRatingPresenterFactory
    }
}

private extension PostInteractor {
    func processPost(post: Post) {
        let postTitlePresenter = postTitlePresenterFactory.createPostTitleViewPresenter(post: post)
        let postInfoPresenter = postInfoPresenterFactory.createPostInfoViewPresenter(post: post)
        let postTextPresenter = postTextPresenterFactory.createPostTextViewPresenter(post: post)
        let postTagsCollectionPresenter = post.tags.count > 0
            ? postTagsCollectionPresenterFactory.createPostTagsCollectionViewPresenter(post: post)
            : nil
        let postRatingPresenter = postRatingPresenterFactory.createPostRatingViewPresenter(post: post)
        
        var cellPresenters: [CellPresenter] = []
        
        cellPresenters.append(postTitlePresenter)
        cellPresenters.append(postInfoPresenter)
        cellPresenters.append(postTextPresenter)
        if let postTagsCollectionPresenter = postTagsCollectionPresenter {
            cellPresenters.append(postTagsCollectionPresenter)
        }
        cellPresenters.append(postRatingPresenter)
        
        presenter?.updatePostCellPresenters(cellPresenters)
    }
}

extension PostInteractor: PostInteractorInput {
    func prepareTableStructure(post: Post) {
        processPost(post: post)
    }
}
