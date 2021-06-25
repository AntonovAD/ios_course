//

import UIKit

class PostViewController: UIViewController {
    private var presenter: PostViewControllerOutput?
    
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
                dataProvider: postDataProvider
            ),
            delegate: TableViewDelegate(didSelectRow: { _ in })
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.registerReusableCell(PostInfoView.self)
        postTableView.registerReusableCell(PostTextView.self)
        postTableView.registerReusableCell(PostRatingView.self)
        
        postTableView.dataSource = postTableData.source
        postTableView.delegate = postTableData.delegate
        
        setupView()
        
        presenter?.viewIsReady()
    }
}

extension PostViewController: PostViewControllerInput {
    func reloadTable() {
        postTableView.reloadData()
    }
    
    func updateTitle(_ text: String) {
        navigationItem.title = text
    }
}

private extension PostViewController {
    //MARK: - Setup()
    func setupView() {
        setTitleBar()
    }
    
    func setTitleBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
