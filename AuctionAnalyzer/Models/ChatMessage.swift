import Foundation

struct ChatMessage: Identifiable {
    enum Role {
        case system
        case user
        case assistant
    }

    let id: UUID
    let role: Role
    let content: String

    init(id: UUID = UUID(), role: Role, content: String) {
        self.id = id
        self.role = role
        self.content = content
    }
}
