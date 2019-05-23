import UIKit

class LaunchCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var launchPadLabel: UILabel!
    @IBOutlet private weak var rocketLabel: UILabel!
    @IBOutlet private weak var patchImageView: UIImageView!

    private var viewModel: LaunchCellViewModel?
}

extension LaunchCell {
    func configure(with viewModel: LaunchCellViewModel) {
        self.viewModel = viewModel

        setupLabels()
    }
}

extension LaunchCell {
    private func setupLabels() {
        titleLabel.text = viewModel?.missionName
        dateLabel.text = viewModel?.launchDate
        launchPadLabel.text = viewModel?.siteShortName
        rocketLabel.text = viewModel?.rocketName
    }
}
