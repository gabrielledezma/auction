import Foundation

@MainActor
final class TermsViewModel: ObservableObject {
    @Published var acceptedTerms = false

    var termsText: String {
        """
        Al usar AuctionAnalyzer, aceptas que el análisis generado por IA es una referencia informativa y no constituye asesoría legal ni financiera.

        Debes validar por tu cuenta el estado del vehículo, historial mecánico, costos de reparación y documentación antes de ofertar.

        Tus datos locales se almacenan únicamente en este dispositivo para fines de historial del análisis.
        """
    }
}
