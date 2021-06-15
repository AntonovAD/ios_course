//

import UIKit

class PostListViewController: UIViewController {
    private var presenter: PostListViewControllerOutput?
    
    @IBOutlet weak var postListTableView: UITableView!
    private var postListTableData: (
        source: TableDataSource?,
        delegate: TableViewDelegate?
    )
    
    convenience init(
        presenter: PostListViewControllerOutput,
        postListDataProvider: TableDataProviderProtocol
    ) {
        self.init()
        
        self.presenter = presenter
        
        self.postListTableData = (
            source: TableDataSource(
                dataProvider: postListDataProvider,
                cellSetup: { cell, presenter in
                    guard let cell = cell as? PostCardView else {
                        return
                    }
                    
                    cell.setup(
                        with: presenter,
                        margin: UIEdgeInsets(
                            top: ViewIndent.small.rawValue,
                            left: ViewIndent.small.rawValue,
                            bottom: ViewIndent.small.rawValue,
                            right: ViewIndent.small.rawValue
                        )
                    )
                }
            ),
            delegate: TableViewDelegate(didSelectRow: didSelectRow(at:))
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        postListTableView.registerReusableCell(PostCardView.self)
        
        postListTableView.contentInset = UIEdgeInsets(
            top: ViewIndent.normal.rawValue,
            left: 0,
            bottom: ViewIndent.normal.rawValue,
            right: 0
        )
        
        postListTableView.dataSource = postListTableData.source
        postListTableView.delegate = postListTableData.delegate
        
        presenter?.viewIsReady()
    }
}

extension PostListViewController: PostListViewControllerInput {
    func reloadTable() {
        postListTableView.reloadData()
    }
    
    func updateTitle(_ text: String) {
        navigationItem.title = text
    }
}

private extension PostListViewController {
    func didSelectRow(at indexPath: IndexPath) {
        presenter?.didSelectCell(with: indexPath)
    }
}
