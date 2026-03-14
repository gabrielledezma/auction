import Foundation

@MainActor
final class LaunchViewModel: ObservableObject {
    @Published var isActive = true

    func start(completion: @escaping () -> Void) {
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            isActive = false
            completion()
        }
    }
}
