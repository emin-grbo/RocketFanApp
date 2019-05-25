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
}
