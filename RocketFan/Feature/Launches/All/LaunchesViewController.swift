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
            self?.setupLoadedState(with: launches)
        }
    }

    private func setupLoadedState(with launches: [Launch]) {
        title = "Launches"
        setupeNavigationBar()

        let launchesVC = LaunchTableViewController(with: launches)
        contentStateViewController.transition(to: .render(launchesVC))
    }

    private func setupeNavigationBar() {
        navigationItem.searchController = setupSearchController()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupSearchController() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchBar.placeholder = "Search Launches"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self

        setupScopeBar(for: searchController.searchBar)

        return searchController
    }

    private func setupScopeBar(for searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.scopeButtonTitles = ["Past", "Upcoming"]
    }
}

extension LaunchesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension LaunchesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
}
