import UIKit

class LaunchDetailsViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var flightNumberLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!

    private let viewModel: LaunchDetailsViewModel

    init(viewModel: LaunchDetailsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabelText()
        addCustomSpacingBeforeDescriptionLabel()
    }

    private func setupLabelText() {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        flightNumberLabel.text = viewModel.flightNumber
        descriptionLabel.text = viewModel.description
    }

    private func addCustomSpacingBeforeDescriptionLabel() {
        stackView.setCustomSpacing(Constants.viewControllerInteritemSpacing, after: flightNumberLabel)
    }
}
