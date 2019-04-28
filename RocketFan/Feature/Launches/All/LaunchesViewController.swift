import UIKit

class LaunchesViewController: UIViewController {
    private lazy var contentStateViewController = ContentStateViewController()
    private let repository: LaunchesRepository

    init(with repository: LaunchesRepository) {

        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        contentStateViewController.transition(to: .loading)
    }
}
