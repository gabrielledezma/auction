import SwiftUI

@main
struct AuctionAnalyzerApp: App {
    @StateObject private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .preferredColorScheme(.light)
        }
    }
}
