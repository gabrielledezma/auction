import SwiftUI

struct RecommendationCardView: View {
    let recommendation: String

    var body: some View {
        SectionCard(title: "Recomendación final") {
            Text(recommendation)
                .font(.body.weight(.semibold))
                .foregroundStyle(.primary)
        }
    }
}
