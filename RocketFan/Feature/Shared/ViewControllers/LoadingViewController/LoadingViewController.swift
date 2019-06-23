import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
    }
}
