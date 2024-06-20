import Foundation

struct Vault: Identifiable {
    let id = UUID()
    let name: String
    let yield: Double
    let riskRating: String
    let info: String
}
