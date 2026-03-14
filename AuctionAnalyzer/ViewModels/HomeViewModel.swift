import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var lotNumber = ""

    var canAnalyze: Bool {
        lotNumber.trimmingCharacters(in: .whitespacesAndNewlines).count >= 4
    }
}
