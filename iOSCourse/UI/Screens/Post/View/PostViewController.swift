//

import UIKit

class PostViewController: UIViewController {
    private var presenter: PostViewControllerOutput?
    private let queue = DispatchQueue.main
    
    @IBOutlet weak var postTableView: UITableView!
    private var postTableData: (
        source: TableDataSource?,
        delegate: TableViewDelegate?
    )
    
    convenience init(
        presenter: PostViewControllerOutput,
        postDataProvider: TableDataProviderProtocol
    ) {
        self.init()
        
        self.presenter = presenter
        
        self.postTableData = (
            source: TableDataSource(
                dataProvider: postDataProvider,
                cellSetup: { cell, presenter in
                    
                    cell.selectionStyle = .none
                    
                    if let cell = cell as? ViewMeasuresSetup {
                        cell.setup(
                            with: presenter,
                            margin: UIEdgeInsets(
                                top: 0,
                                left: ViewIndent.large.rawValue,
                                bottom: 0,
                                right: ViewIndent.large.rawValue
                            )
                        )
                    } else {
                        return
                    }
                }
            ),
            delegate: TableViewDelegate(didSelectRow: { _ in })
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.registerReusableCell(PostTitleView.self)
        postTableView.registerReusableCell(PostInfoView.self)
        postTableView.registerReusableCell(PostTextView.self)
        postTableView.registerReusableCell(PostTagsCollectionView.self)
        postTableView.registerReusableCell(PostRatingView.self)
        
        postTableView.dataSource = postTableData.source
        postTableView.delegate = postTableData.delegate
        
        setupView()
        
        presenter?.viewIsReady()
    }
}

extension PostViewController: PostViewControllerInput {
    func reloadTable() {
        queue.async {
            self.postTableView.reloadData()
        }
    }
    
    func updateTitle(_ text: String) {
        queue.async {
            //self.navigationItem.title = text
            self.navigationItem.title = nil
        }
    }
}

private extension PostViewController {
    //MARK: - Setup()
    func setupView() {
        queue.async {
            self.setTitleBar()
            self.setMeasures()
            self.setTable()
        }
    }
    
    func setTitleBar() {
        /*navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()*/
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setMeasures() {
        postTableView.contentInset = UIEdgeInsets(
            top: ViewIndent.large.rawValue,
            left: 0,
            bottom: ViewIndent.large.rawValue,
            right: 0
        )
    }
    
    func setTable() {
        postTableView.contentInsetAdjustmentBehavior = .never
    }
}
