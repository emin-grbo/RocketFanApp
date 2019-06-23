import SwiftUI

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
        viewModel.didFinishLoading = { [weak self] loaded in
            if loaded == false { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.setupLoadedState()
            }
        }
    }
    
    private func setupLoadedState() {
        title = "Launches"
        setupeNavigationBar()
        
        let listView = LaunchesListView(model: viewModel)
        let hostingVC = UIHostingController(rootView: listView)
        
        contentStateViewController.transition(to: .render(hostingVC))
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
        guard let searchTerm = searchController.searchBar.text else { return }
        
        viewModel.findLaunchesMatching(searchTerm)
    }
}

extension LaunchesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let filter: LaunchesViewModel.Filter = selectedScope == 0 ? .past : .upcoming
        
        viewModel.filterLaunches(by: filter)
    }
}
