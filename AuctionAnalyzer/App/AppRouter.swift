import Foundation

final class AppRouter: ObservableObject {
    @Published var path: [AppRoute] = []

    func goToTerms() {
        path = [.terms]
    }

    func goToHome() {
        path = [.home]
    }

    func goToAnalysis(lotNumber: String) {
        path.append(.analysis(lotNumber: lotNumber))
    }

    func goToHistory() {
        path.append(.history)
    }

    func popToHome() {
        path = [.home]
    }
}
