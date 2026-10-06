import SwiftUI
import WebKit

struct AnimatedImage: UIViewRepresentable {

    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url else {
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}
