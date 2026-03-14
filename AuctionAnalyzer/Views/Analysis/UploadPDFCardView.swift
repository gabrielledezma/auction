import SwiftUI

struct UploadPDFCardView: View {
    let fileName: String?
    let action: () -> Void

    var body: some View {
        SectionCard(title: "CARFAX para mayor precisión") {
            VStack(alignment: .leading, spacing: 10) {
                Text("Sube el PDF de CARFAX para mejorar el análisis y reducir incertidumbre.")
                if let fileName {
                    Label("Archivo cargado: \(fileName)", systemImage: "doc.text.fill")
                        .font(.caption)
                }
                Button("Importar PDF", action: action)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}
