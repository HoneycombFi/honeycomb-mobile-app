import Foundation

struct ERC20Token: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let logo: String
    let balance: String
    let priceInUSD: Double
}

struct Vault: Identifiable {
    let id = UUID()
    let name: String
    let yield: Double
    let info: String
}
