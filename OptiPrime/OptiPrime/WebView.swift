import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    
    let url: URL
    
    func makeNSView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        
        // Native configuration for optimal media rendering
        webConfiguration.allowsAirPlayForMediaPlayback = true
        
        // These settings expose standard HTML5 media APIs to the browser process
        let preferences = WKPreferences()
        webConfiguration.preferences = preferences
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        // Set Safari User Agent to ensure Prime Video serves native WebKit-optimized media profiles
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15"
        
        return webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        if nsView.url == nil {
            let request = URLRequest(url: url)
            nsView.load(request)
        }
    }
}
