import SwiftUI

struct ContentView: View {
    // The URL for the Prime Video storefront
    private let primeVideoURL = URL(string: "https://www.primevideo.com")!
    
    var body: some View {
        WebView(url: primeVideoURL)
            .ignoresSafeArea() // This will compile perfectly now!
            .frame(minWidth: 1024, minHeight: 768) // Sets a standard start size for desktop viewing
    }
}
