import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(isEnabled ? AppTheme.primary : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .disabled(!isEnabled)
    }
}

#Preview {
    PrimaryButton(title: "Continuar", isEnabled: true, action: {})
        .padding()
}
