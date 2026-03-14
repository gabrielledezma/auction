import Foundation

struct SavedAnalysis: Codable, Identifiable {
    let id: UUID
    let lotNumber: String
    let date: Date
    let summary: String
    let report: AnalysisReport
}
