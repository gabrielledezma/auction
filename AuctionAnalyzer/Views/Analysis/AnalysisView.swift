import SwiftUI

struct AnalysisView: View {
    @StateObject var viewModel: AnalysisViewModel
    @State private var showingImporter = false
    @State private var showingShare = false

    private let shareService = ShareService()

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                if !viewModel.initialAnalysis.isEmpty {
                    SectionCard(title: "Análisis inicial") {
                        ChatBubbleView(text: viewModel.initialAnalysis, isAssistant: true)
                    }
                } else {
                    ContentUnavailableView(
                        "Preparando análisis",
                        systemImage: "waveform.and.magnifyingglass",
                        description: Text("Estamos consultando la IA con el número de lote.")
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                }

                UploadPDFCardView(fileName: viewModel.importedCarfaxName) {
                    showingImporter = true
                }

                if let advanced = viewModel.advancedAnalysis {
                    SectionCard(title: "Análisis avanzado") {
                        ChatBubbleView(text: advanced, isAssistant: true)
                    }
                }

                if let estimate = viewModel.financialEstimate {
                    FinancialSummaryCard(estimate: estimate)
                }

                if !viewModel.finalRecommendation.isEmpty {
                    RecommendationCardView(recommendation: viewModel.finalRecommendation)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                if viewModel.currentReport != nil {
                    Button("Compartir reporte") { showingShare = true }
                        .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        .background(AppTheme.background)
        .navigationTitle("Análisis")
        .fileImporter(
            isPresented: $showingImporter,
            allowedContentTypes: [.pdf],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case let .success(urls):
                guard let url = urls.first else { return }
                Task { await viewModel.importAndAnalyzePDF(from: url) }
            case let .failure(error):
                viewModel.errorMessage = error.localizedDescription
            }
        }
        .sheet(isPresented: $showingShare) {
            if let report = viewModel.currentReport {
                ActivityViewController(items: [shareService.buildReportText(report)])
            }
        }
        .overlay {
            if viewModel.isLoading {
                LoadingOverlay(message: "Analizando vehículo…")
            }
        }
        .task {
            if viewModel.initialAnalysis.isEmpty {
                await viewModel.loadInitialAnalysis()
            }
        }
    }
}
