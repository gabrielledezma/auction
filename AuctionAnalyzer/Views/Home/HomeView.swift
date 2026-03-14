import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack(spacing: 16) {
            SectionCard(title: "Número de lote") {
                TextField("Ej: 78392014", text: $viewModel.lotNumber)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .padding(12)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }

            PrimaryButton(title: "Analizar vehículo", isEnabled: viewModel.canAnalyze) {
                router.goToAnalysis(lotNumber: viewModel.lotNumber)
            }

            Button("Ver historial") {
                router.goToHistory()
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .navigationTitle("Inicio")
        .background(AppTheme.background)
    }
}
