import SwiftUI

struct ChatBubbleView: View {
    let text: String
    let isAssistant: Bool

    var body: some View {
        HStack {
            if isAssistant {
                bubble
                Spacer(minLength: 40)
            } else {
                Spacer(minLength: 40)
                bubble
            }
        }
    }

    private var bubble: some View {
        Text(text)
            .padding(12)
            .foregroundStyle(isAssistant ? .primary : .white)
            .background(isAssistant ? AppTheme.cardBackground : AppTheme.primary)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}
