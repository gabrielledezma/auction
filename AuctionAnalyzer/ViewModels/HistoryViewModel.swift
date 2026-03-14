import Foundation

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published private(set) var items: [SavedAnalysis] = []
    private let service: AnalysisHistoryService

    init(service: AnalysisHistoryService = AnalysisHistoryService()) {
        self.service = service
    }

    func load() {
        items = service.fetchAll()
    }
}
