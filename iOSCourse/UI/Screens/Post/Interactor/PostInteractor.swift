//

import Foundation

class PostInteractor {
    private let postProvider: ReactivePostProviderProtocol
    
    private let postTitlePresenterFactory: PostTitleViewPresenterFactoryProtocol
    private let postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol
    private let postTextPresenterFactory: PostTextViewPresenterFactoryProtocol
    private let postTagsCollectionPresenterFactory: PostTagsCollectionViewPresenterFactoryProtocol
    private let postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    
    weak var presenter: PostInteractorOutput?
    
    init(
        postProvider: ReactivePostProviderProtocol,
        postTitlePresenterFactory: PostTitleViewPresenterFactoryProtocol,
        postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol,
        postTextPresenterFactory: PostTextViewPresenterFactoryProtocol,
        postTagsCollectionPresenterFactory: PostTagsCollectionViewPresenterFactoryProtocol,
        postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    ) {
        self.postProvider = postProvider
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
        let postRatingPresenter = postRatingPresenterFactory.createPostRatingViewPresenter(
            post: post,
            likeAction: likeDidSelect(post:),
            dislikeAction: dislikeDidSelect(post:)
        )
        
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
    
    func handleError(_ error: Error) {
        presenter?.handleError(error)
    }
    
    func likeDidSelect(post: Post) {
        postProvider.rate(post: post, value: 1).startWithResult { [weak self] result in
            switch result {
            case .success(let response):
                self?.processPost(post: response)
                
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    func dislikeDidSelect(post: Post) {
        postProvider.rate(post: post, value: 0).startWithResult { [weak self] result in
            switch result {
            case .success(let response):
                self?.processPost(post: response)
                
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
}

extension PostInteractor: PostInteractorInput {
    func prepareTableStructure(post: Post) {
        processPost(post: post)
    }
}
