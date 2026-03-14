import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel = LaunchViewModel()

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.9), .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "car.fill")
                    .font(.system(size: 64, weight: .semibold))
                    .foregroundStyle(.white)
                    .symbolEffect(.pulse)

                Text("AuctionAnalyzer")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text("Analizando oportunidades de subasta")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .task {
            viewModel.start {
                router.goToTerms()
            }
        }
    }
}
