import Foundation

struct ERC20Token: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let logo: String
    let balance: String
    let priceInUSD: Double
}

struct Flower: Identifiable {
    let id = UUID()
    let contract: String
    let name: String
    let logo: String
    let info: String
    var balance: String = "0"
    var yield: Double = 0.0
}
