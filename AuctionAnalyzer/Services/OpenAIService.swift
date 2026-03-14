import Foundation

enum OpenAIServiceError: LocalizedError {
    case invalidResponse
    case missingContent

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "La respuesta de OpenAI no es válida."
        case .missingContent:
            return "No se recibió contenido de análisis."
        }
    }
}

final class OpenAIService {
    // ADVERTENCIA: en producción NO guardes la API key directamente en la app.
    // Usa un backend seguro o un proveedor de secretos.
    private let apiKey = "CONFIGURA_AQUI_TU_API_KEY"
    private let session: URLSession
    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!

    init(session: URLSession = .shared) {
        self.session = session
    }

    func generateInitialAnalysis(lotNumber: String) async throws -> String {
        let prompt = "Analiza en español un vehículo de subasta con número de lote \(lotNumber). Incluye riesgos, oportunidad y recomendaciones iniciales."
        return try await requestAnalysis(prompt: prompt)
    }

    func generateAdvancedAnalysis(lotNumber: String, carfaxText: String) async throws -> String {
        let prompt = "Analiza en español el lote \(lotNumber) usando este CARFAX: \(carfaxText). Resume historial, daños, mantenimientos y riesgos de compra."
        return try await requestAnalysis(prompt: prompt)
    }

    private func requestAnalysis(prompt: String) async throws -> String {
        struct RequestBody: Codable {
            struct Message: Codable {
                let role: String
                let content: String
            }

            let model: String
            let messages: [Message]
            let temperature: Double
        }

        struct ResponseBody: Codable {
            struct Choice: Codable {
                struct Message: Codable {
                    let role: String
                    let content: String
                }

                let message: Message
            }

            let choices: [Choice]
        }

        let body = RequestBody(
            model: "gpt-4o-mini",
            messages: [
                .init(role: "system", content: "Eres un analista automotriz experto. Siempre respondes en español de forma clara y profesional."),
                .init(role: "user", content: prompt)
            ],
            temperature: 0.3
        )

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw OpenAIServiceError.invalidResponse
        }

        let decoded = try JSONDecoder().decode(ResponseBody.self, from: data)
        guard let content = decoded.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines),
              !content.isEmpty else {
            throw OpenAIServiceError.missingContent
        }

        return content
    }
}
