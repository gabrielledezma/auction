import Foundation
import PDFKit

enum PDFExtractorError: LocalizedError {
    case cannotOpenFile
    case noText

    var errorDescription: String? {
        switch self {
        case .cannotOpenFile:
            return "No se pudo abrir el archivo PDF."
        case .noText:
            return "No se encontró texto legible en el PDF."
        }
    }
}

final class PDFExtractorService {
    func extractText(from url: URL) throws -> String {
        guard let document = PDFDocument(url: url) else {
            throw PDFExtractorError.cannotOpenFile
        }

        let allText = (0..<document.pageCount)
            .compactMap { document.page(at: $0)?.string }
            .joined(separator: "\n")
            .replacingOccurrences(of: "\n\n\n", with: "\n\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !allText.isEmpty else {
            throw PDFExtractorError.noText
        }

        return allText
    }
}
