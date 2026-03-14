import SwiftUI

struct FinancialSummaryCard: View {
    let estimate: FinancialEstimate

    var body: some View {
        SectionCard(title: "Resumen financiero") {
            VStack(alignment: .leading, spacing: 8) {
                financialLine("Puja máxima recomendada", estimate.recommendedMaxBid)
                financialLine("Precio estimado venta privada", estimate.estimatedPrivateSalePrice)
                financialLine("Costo estimado de reparación", estimate.estimatedRepairCost)
                financialLine("Fees de subasta", estimate.auctionFees)
                financialLine("Transporte", estimate.transportCost)
                financialLine("Reserva de riesgo", estimate.riskReserve)
                financialLine("Margen potencial de ganancia", estimate.potentialProfitMargin, highlighted: true)
            }
        }
    }

    private func financialLine(_ title: String, _ amount: Double, highlighted: Bool = false) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(amount, format: .currency(code: "USD").precision(.fractionLength(0)))
                .fontWeight(highlighted ? .bold : .regular)
                .foregroundStyle(highlighted ? .green : .primary)
        }
    }
}
