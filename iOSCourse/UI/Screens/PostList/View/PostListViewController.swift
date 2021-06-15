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
                            top: ViewIndent.normal.rawValue,
                            left: ViewIndent.normal.rawValue,
                            bottom: ViewIndent.normal.rawValue,
                            right: ViewIndent.normal.rawValue
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
            top: ViewIndent.large.rawValue,
            left: 0,
            bottom: ViewIndent.large.rawValue,
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
