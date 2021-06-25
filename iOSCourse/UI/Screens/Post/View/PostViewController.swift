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
                dataProvider: postDataProvider,
                cellSetup: { cell, presenter in
                    guard let cell = cell as? ViewMeasuresSetup else {
                        return
                    }
                    
                    cell.setup(
                        with: presenter,
                        margin: UIEdgeInsets(
                            top: 0,
                            left: ViewIndent.large.rawValue,
                            bottom: 0,
                            right: ViewIndent.large.rawValue
                        )
                    )
                }
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
        setMeasures()
        setTable()
    }
    
    func setTitleBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
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
