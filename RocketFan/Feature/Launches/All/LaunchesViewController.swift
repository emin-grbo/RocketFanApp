import UIKit

class LaunchesViewController: UIViewController {
    private lazy var contentStateViewController = ContentStateViewController()
    private var repository: LaunchesRepository

    init(with repository: LaunchesRepository) {
        self.repository = repository

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Launches"
        view.backgroundColor = .white
        add(contentStateViewController)
        fetchData()
    }
}

extension LaunchesViewController {
    private func fetchData() {
        repository.allLaunches { [weak self] (result) in

            do {
                let launches = try result.get()
                self?.handleSuccess(with: launches)

            } catch {
                self?.contentStateViewController.transition(to: .failed(error))
            }
        }
    }

    private func handleSuccess(with launches: [Launch]) {
        DispatchQueue.main.async { [weak self] in
            let launchesVC = LaunchTableViewController(with: launches)
            self?.contentStateViewController.transition(to: .render(launchesVC))
        }
    }
}
