import UIKit

class LaunchTableViewDataSource: NSObject {
    private var launches: [Launch]?
    private let dateFormatter = DateFormatter()

    init(with launches: [Launch]) {
        self.launches = launches
    }
}

extension LaunchTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LaunchCell = tableView.dequeueReusableCell(for: indexPath)
        guard let viewModel = launchViewModel(for: indexPath) else { return cell }

        cell.configure(with: viewModel)
        
        return cell
    }
}

extension LaunchTableViewDataSource {
    private func launchViewModel(for indexPath: IndexPath) -> LaunchCellViewModel? {
        guard let launch = launches?[indexPath.row] else { return nil }

        return LaunchCellViewModel(with: launch, dateFormatter)
    }
}
