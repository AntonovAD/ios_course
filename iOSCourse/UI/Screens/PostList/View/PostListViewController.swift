//

import UIKit

class PostListViewController: UIViewController {
    private var presenter: PostListViewControllerOutput?
    
    @IBOutlet weak var postListTableView: UITableView!
    private var postListTableData: (
        source: TableDataSource?,
        delegate: TableViewDelegate?
    )
    
    var titleBarSizeObserver: NSKeyValueObservation?
    
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
        
        postListTableView.registerReusableCell(PostCardView.self)
        
        postListTableView.dataSource = postListTableData.source
        postListTableView.delegate = postListTableData.delegate
        
        setupView()
        
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
    
    func updateUserInfo(_ name: String, _ email: String) {
        let titleLabel = UILabel()
        titleLabel.text = name
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline)

        let subtitleLabel = UILabel()
        subtitleLabel.text = email
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.axis = .vertical

        let userInfo = UIBarButtonItem(customView: stackView)
        self.navigationItem.leftBarButtonItems = [userInfo]
    }
}

private extension PostListViewController {
    //MARK: - Private Func()
    func didSelectRow(at indexPath: IndexPath) {
        presenter?.didSelectCell(with: indexPath)
    }
    
    //MARK: - Setup()
    func setupView() {
        setTitleBar()
        setRightItem()
        setMeasures()
        setObservers()
    }
    
    func setTitleBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setRightItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: .none)
        self.navigationItem.rightBarButtonItems = [addButton]
    }
    
    func setMeasures() {
        postListTableView.contentInset = UIEdgeInsets(
            top: ViewIndent.large.rawValue,
            left: 0,
            bottom: ViewIndent.large.rawValue,
            right: 0
        )
    }
    
    func setObservers() {
        /*titleBarSizeObserver = navigationController?.navigationBar.observe(
            \.bounds,
            options: [.new],
            changeHandler: { navigationBar, changes in
                //option n1
                if let height = changes.newValue?.height {
                    if height > 44.0 { //fixed const
                        self.title = "Large Title" //Large Title
                    } else {
                        self.title = "Small Title" //Small Title
                    }
                }
                
                //option n2
                let heightForCollapsedNav = UINavigationController().navigationBar.frame.size.height
                let navHeight = self.navigationController!.navigationBar.frame.size.height
                self.navigationController?.navigationBar.topItem?.title = navHeight <= heightForCollapsedNav  ? "Collapsed" : "Large"
                print(navHeight <= heightForCollapsedNav  ? "Collapsed" : "Large")
            }
        )*/
    }
}
