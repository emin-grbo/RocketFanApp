import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet private weak var activityIndivator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        activityIndivator.startAnimating()
    }
}
