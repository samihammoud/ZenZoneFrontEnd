import SwiftUI
import WebKit


/// A SwiftUI wrapper for a WKWebView to display a YouTube video.
struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String // The YouTube video ID (e.g., "dQw4w9WgXcQ")
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Use the videoID property to dynamically load the video
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            print("Invalid YouTube video ID: \(videoID)")
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
