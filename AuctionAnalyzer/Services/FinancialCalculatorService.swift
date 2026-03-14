import Foundation

final class FinancialCalculatorService {
    func calculateEstimate(basedOn lotNumber: String, hasCarfax: Bool) -> FinancialEstimate {
        let numericValue = Double(lotNumber.filter(\.isNumber)) ?? 100000
        let baseMarketValue = max(8500, (numericValue.truncatingRemainder(dividingBy: 22000)) + 9000)

        let repairRate = hasCarfax ? 0.16 : 0.22
        let feeRate = 0.08
        let transport = 780.0
        let riskRate = hasCarfax ? 0.06 : 0.1

        let repairCost = baseMarketValue * repairRate
        let auctionFees = baseMarketValue * feeRate
        let riskReserve = baseMarketValue * riskRate

        let totalCosts = repairCost + auctionFees + transport + riskReserve
        let maxBid = max(1000, baseMarketValue - totalCosts)
        let margin = baseMarketValue - (maxBid + totalCosts)

        return FinancialEstimate(
            estimatedPrivateSalePrice: baseMarketValue,
            estimatedRepairCost: repairCost,
            auctionFees: auctionFees,
            transportCost: transport,
            riskReserve: riskReserve,
            recommendedMaxBid: maxBid,
            potentialProfitMargin: margin
        )
    }
}
