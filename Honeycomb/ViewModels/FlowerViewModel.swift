import SwiftUI
import Combine

@MainActor
class FlowersViewModel: ObservableObject {
    @Published var flowers: [Flower] = Constants.Networks.BaseSepolia.Flowers.all

    func fetchFlowerBalances(walletAddress: String) {
        Task {
            do {
                var balanceMap: [String: String] = [:]
                var yieldMap: [String: Double] = [:]

                try await withThrowingTaskGroup(of: (String, String, Double).self) { group in
                    for flower in Constants.Networks.BaseSepolia.Flowers.all {
                        group.addTask {
                            let balance = try await HiveManager.shared.getFlowerBalance(userAddress: walletAddress, flowerAddress: flower.contract)
                            let yield = await HiveManager.shared.getFlowerYield(flowerAddress: flower.contract)
                            return (flower.contract, balance, yield)
                        }
                    }

                    for try await (contract, balance, yield) in group {
                        balanceMap[contract] = balance
                        yieldMap[contract] = yield
                    }
                }

                // Update the @Published property while preserving order
                var updatedFlowers: [Flower] = []
                for flower in Constants.Networks.BaseSepolia.Flowers.all {
                    var updatedFlower = flower
                    if let balance = balanceMap[flower.contract] {
                        updatedFlower.balance = balance
                    }
                    if let yield = yieldMap[flower.contract] {
                        updatedFlower.yield = yield
                    }
                    updatedFlowers.append(updatedFlower)
                }
                self.flowers = updatedFlowers
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
