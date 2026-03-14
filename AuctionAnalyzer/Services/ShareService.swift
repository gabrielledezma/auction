import SwiftUI
import UIKit

struct ActivityViewController: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

final class ShareService {
    func buildReportText(_ report: AnalysisReport) -> String {
        """
        Reporte del lote: \(report.vehicle.lotNumber)
        Fecha: \(report.createdAt.formatted(date: .abbreviated, time: .shortened))

        Análisis inicial:
        \(report.initialAnalysis)

        Análisis avanzado:
        \(report.advancedAnalysis ?? "No disponible")

        Puja máxima recomendada: $\(Int(report.financialEstimate.recommendedMaxBid))
        Precio estimado venta privada: $\(Int(report.financialEstimate.estimatedPrivateSalePrice))
        Costo estimado reparación: $\(Int(report.financialEstimate.estimatedRepairCost))
        Margen potencial: $\(Int(report.financialEstimate.potentialProfitMargin))

        Recomendación final:
        \(report.finalRecommendation)
        """
    }
}
