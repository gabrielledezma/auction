import Foundation

@MainActor
final class AnalysisViewModel: ObservableObject {
    @Published var initialAnalysis = ""
    @Published var advancedAnalysis: String?
    @Published var financialEstimate: FinancialEstimate?
    @Published var finalRecommendation = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var importedCarfaxName: String?
    @Published var currentReport: AnalysisReport?

    private let lotNumber: String
    private let openAIService: OpenAIService
    private let pdfExtractorService: PDFExtractorService
    private let financialService: FinancialCalculatorService
    private let historyService: AnalysisHistoryService

    init(
        lotNumber: String,
        openAIService: OpenAIService = OpenAIService(),
        pdfExtractorService: PDFExtractorService = PDFExtractorService(),
        financialService: FinancialCalculatorService = FinancialCalculatorService(),
        historyService: AnalysisHistoryService = AnalysisHistoryService()
    ) {
        self.lotNumber = lotNumber
        self.openAIService = openAIService
        self.pdfExtractorService = pdfExtractorService
        self.financialService = financialService
        self.historyService = historyService
    }

    func loadInitialAnalysis() async {
        isLoading = true
        errorMessage = nil

        do {
            initialAnalysis = try await openAIService.generateInitialAnalysis(lotNumber: lotNumber)
            financialEstimate = financialService.calculateEstimate(basedOn: lotNumber, hasCarfax: false)
            finalRecommendation = buildRecommendation()
            buildAndPersistReport()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func importAndAnalyzePDF(from url: URL) async {
        isLoading = true
        errorMessage = nil

        do {
            let text = try pdfExtractorService.extractText(from: url)
            importedCarfaxName = url.lastPathComponent
            advancedAnalysis = try await openAIService.generateAdvancedAnalysis(lotNumber: lotNumber, carfaxText: text)
            financialEstimate = financialService.calculateEstimate(basedOn: lotNumber, hasCarfax: true)
            finalRecommendation = buildRecommendation()
            buildAndPersistReport()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func buildRecommendation() -> String {
        guard let estimate = financialEstimate else {
            return "Aún no hay suficientes datos para recomendar una decisión."
        }

        if estimate.potentialProfitMargin > 1200 {
            return "Compra recomendada con control: el lote muestra margen positivo y riesgo moderado."
        } else if estimate.potentialProfitMargin > 400 {
            return "Compra posible con precaución: negocia costos de reparación y evita sobrepujar."
        } else {
            return "No recomendable para inversión rápida: margen limitado frente al riesgo operativo."
        }
    }

    private func buildAndPersistReport() {
        guard let financialEstimate else { return }

        let vehicle = AuctionVehicle(lotNumber: lotNumber)
        let report = AnalysisReport(
            vehicle: vehicle,
            initialAnalysis: initialAnalysis,
            advancedAnalysis: advancedAnalysis,
            financialEstimate: financialEstimate,
            finalRecommendation: finalRecommendation
        )
        currentReport = report
        historyService.save(report: report)
    }
}
