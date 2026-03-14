import SwiftUI

struct RootView: View {
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            LaunchView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .terms:
                        TermsView()
                    case .home:
                        HomeView()
                    case let .analysis(lotNumber):
                        AnalysisView(viewModel: AnalysisViewModel(lotNumber: lotNumber))
                    case .history:
                        HistoryView()
                    }
                }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AppRouter())
}
