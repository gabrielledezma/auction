import Foundation

struct AnalysisReport: Codable, Identifiable {
    let id: UUID
    let vehicle: AuctionVehicle
    let initialAnalysis: String
    let advancedAnalysis: String?
    let financialEstimate: FinancialEstimate
    let finalRecommendation: String
    let createdAt: Date

    init(
        id: UUID = UUID(),
        vehicle: AuctionVehicle,
        initialAnalysis: String,
        advancedAnalysis: String? = nil,
        financialEstimate: FinancialEstimate,
        finalRecommendation: String,
        createdAt: Date = .now
    ) {
        self.id = id
        self.vehicle = vehicle
        self.initialAnalysis = initialAnalysis
        self.advancedAnalysis = advancedAnalysis
        self.financialEstimate = financialEstimate
        self.finalRecommendation = finalRecommendation
        self.createdAt = createdAt
    }

    var shortSummary: String {
        finalRecommendation.count > 95 ? String(finalRecommendation.prefix(95)) + "…" : finalRecommendation
    }
}
