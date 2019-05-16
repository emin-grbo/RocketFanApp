import UIKit
import WebKit

class YouTubeViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    private let videoURL: URL

    init(videoURL: URL) {
        self.videoURL = videoURL

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: videoURL))
    }
}
