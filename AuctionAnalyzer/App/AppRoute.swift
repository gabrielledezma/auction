import Foundation

enum AppRoute: Hashable {
    case terms
    case home
    case analysis(lotNumber: String)
    case history
}
