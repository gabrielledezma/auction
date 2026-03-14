import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()

    var body: some View {
        Group {
            if viewModel.items.isEmpty {
                ContentUnavailableView(
                    "Sin historial todavía",
                    systemImage: "clock.arrow.circlepath",
                    description: Text("Tus análisis guardados aparecerán aquí.")
                )
            } else {
                List(viewModel.items) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Lote #\(item.lotNumber)")
                            .font(.headline)
                        Text(item.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(item.summary)
                            .font(.subheadline)
                            .lineLimit(3)
                    }
                    .padding(.vertical, 6)
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Historial")
        .onAppear { viewModel.load() }
    }
}
