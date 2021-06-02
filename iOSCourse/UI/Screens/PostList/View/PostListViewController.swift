//

import UIKit

class PostListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: PostListViewControllerOutput?
    
    private var tableViewDataSource: TableViewDataSource?
    private var tableViewDelegate: TableViewDelegate?
    
    convenience init(presenter: PostListViewControllerOutput, dataProvider: PostListTableDataProviderProtocol) {
        self.init()
        
        self.presenter = presenter
        
        self.tableViewDataSource = TableViewDataSource(dataProvider: dataProvider)
        self.tableViewDelegate = TableViewDelegate(parent: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.registerReusableCell(PostCardView.self)
        
        tableView.contentInset = UIEdgeInsets(
            top: ViewIndent.normal.rawValue,
            left: 0,
            bottom: ViewIndent.normal.rawValue,
            right: 0
        )
        
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        
        presenter?.viewIsReady()
    }
}

extension PostListViewController: PostListViewControllerInput {
    func reloadTable() {
        tableView.reloadData()
    }
    
    func updateTitle(_ text: String) {
        navigationItem.title = text
    }
}

private extension PostListViewController {
    class TableViewDataSource: NSObject, UITableViewDataSource {
        private let dataProvider: PostListTableDataProviderProtocol
        
        init(dataProvider: PostListTableDataProviderProtocol) {
            self.dataProvider = dataProvider
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return dataProvider.numberOfSections
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataProvider.numberOfRows(in: section)
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let presenter = dataProvider.cellForRow(at: indexPath)
            
            let cell = tableView.dequeueReusableCell(with: presenter, for: indexPath)
            
            if let postCell = cell as? PostCardView {
                postCell.setup(
                    with: presenter,
                    margin: UIEdgeInsets(
                        top: ViewIndent.small.rawValue,
                        left: ViewIndent.small.rawValue,
                        bottom: ViewIndent.small.rawValue,
                        right: ViewIndent.small.rawValue
                    )
                )
            }
            
            return cell
        }
    }
}

private extension PostListViewController {
    func didSelectRow(at indexPath: IndexPath) {
        presenter?.didSelectCell(with: indexPath)
    }
    
    class TableViewDelegate: NSObject, UITableViewDelegate {
        private weak var parent: PostListViewController?
        
        init(parent: PostListViewController) {
            self.parent = parent
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            parent?.didSelectRow(at: indexPath)
        }
    }
}
