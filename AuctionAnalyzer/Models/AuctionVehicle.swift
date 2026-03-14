import Foundation

struct AuctionVehicle: Codable, Identifiable {
    let id: UUID
    let lotNumber: String
    let createdAt: Date

    init(id: UUID = UUID(), lotNumber: String, createdAt: Date = .now) {
        self.id = id
        self.lotNumber = lotNumber
        self.createdAt = createdAt
    }
}
