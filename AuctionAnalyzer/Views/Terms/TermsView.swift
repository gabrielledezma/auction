import SwiftUI

struct TermsView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel = TermsViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Términos y condiciones")
                    .font(.title2.bold())

                SectionCard(title: "Uso responsable") {
                    Text(viewModel.termsText)
                }

                Toggle("Acepto los términos y condiciones", isOn: $viewModel.acceptedTerms)
                    .toggleStyle(.switch)

                PrimaryButton(title: "Continuar", isEnabled: viewModel.acceptedTerms) {
                    router.goToHome()
                }
            }
            .padding()
        }
        .background(AppTheme.background)
        .navigationBarBackButtonHidden(true)
    }
}
