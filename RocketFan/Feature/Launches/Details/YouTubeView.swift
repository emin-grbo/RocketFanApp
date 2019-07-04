import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoId: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView(frame: .zero)
    }

    func updateUIView(_ view: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }

        let request = URLRequest(url: url)
        view.load(request)
    }
}

#if DEBUG
struct YouTubeView_Preview: PreviewProvider {
    static var previews: some View {
        YouTubeView(videoId: launchesTestData[0].links.youtubeId!)
    }
}
#endif
