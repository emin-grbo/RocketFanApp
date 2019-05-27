import UIKit

class LaunchesViewController: UIViewController {
    private lazy var contentStateViewController = ContentStateViewController()
    private let viewModel: LaunchesViewModel

    init(with viewModel: LaunchesViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        add(contentStateViewController)
        bindViewModel()
    }
}

extension LaunchesViewController {
    private func bindViewModel() {
        viewModel.launchesUpdated = { [weak self] launches in
            self?.handleSuccess(with: launches)
        }
    }

    private func handleSuccess(with launches: [Launch]) {
        DispatchQueue.main.async { [weak self] in
            let launchesVC = LaunchTableViewController(with: launches)
            self?.contentStateViewController.transition(to: .render(launchesVC))
        }
    }
}
