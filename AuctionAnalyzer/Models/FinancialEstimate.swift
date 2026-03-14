import Foundation

struct FinancialEstimate: Codable {
    let estimatedPrivateSalePrice: Double
    let estimatedRepairCost: Double
    let auctionFees: Double
    let transportCost: Double
    let riskReserve: Double
    let recommendedMaxBid: Double
    let potentialProfitMargin: Double
}
