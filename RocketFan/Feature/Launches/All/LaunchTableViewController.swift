import UIKit

class LaunchTableViewController: UITableViewController {
    private let dataSource: LaunchTableViewDataSource

    init(with launches: [Launch]) {
        dataSource = LaunchTableViewDataSource(with: launches)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension LaunchTableViewController {
    private func setup() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(cellType: LaunchCell.self)
        tableView.dataSource = dataSource
    }
}
