import Foundation

struct CarfaxDocument: Codable {
    let fileName: String
    let extractedText: String
    let importedAt: Date
}
