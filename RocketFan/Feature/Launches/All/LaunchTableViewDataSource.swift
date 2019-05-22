import UIKit

class LaunchTableViewDataSource: NSObject {
    private var launches: [Launch]?

    func update(with launches: [Launch]) {
        self.launches = launches
    }
}

extension LaunchTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
