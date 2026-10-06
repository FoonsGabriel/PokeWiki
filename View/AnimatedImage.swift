import SwiftUI
import WebKit

struct AnimatedImage: UIViewRepresentable {

    let url: URL?

    func makeUIView(context: Context) -> WKWebView {

        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true

        let webView = WKWebView(
            frame: .zero,
            configuration: configuration
        )

        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.contentMode = .scaleAspectFit

        return webView
    }

    func updateUIView(
        _ webView: WKWebView,
        context: Context
    ) {

        guard let url else {
            return
        }

        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
        <style>
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            background: transparent;
            overflow: hidden;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            image-rendering: auto;
        }
        </style>
        </head>
        <body>
        <img src="\(url.absoluteString)">
        </body>
        </html>
        """

        webView.loadHTMLString(
            html,
            baseURL: nil
        )
    }
}
