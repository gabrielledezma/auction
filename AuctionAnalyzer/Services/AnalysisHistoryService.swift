import Foundation

final class AnalysisHistoryService {
    private let userDefaults: UserDefaults
    private let key = "saved_analyses"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func save(report: AnalysisReport) {
        var all = fetchAll()
        let saved = SavedAnalysis(
            id: report.id,
            lotNumber: report.vehicle.lotNumber,
            date: report.createdAt,
            summary: report.shortSummary,
            report: report
        )
        all.removeAll { $0.id == report.id }
        all.append(saved)
        persist(all)
    }

    func fetchAll() -> [SavedAnalysis] {
        guard let data = userDefaults.data(forKey: key),
              let decoded = try? JSONDecoder().decode([SavedAnalysis].self, from: data) else {
            return []
        }

        return decoded.sorted(by: { $0.date > $1.date })
    }

    private func persist(_ analyses: [SavedAnalysis]) {
        if let data = try? JSONEncoder().encode(analyses) {
            userDefaults.set(data, forKey: key)
        }
    }
}
