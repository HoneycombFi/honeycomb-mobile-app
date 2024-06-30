import SwiftUI
import Combine
import BigInt

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
                            let balance = try await HiveManager.shared.getFlowerBalance(userAddress: walletAddress, flowerAddress: Constants.Networks.BaseSepolia.Honeycomb.hiveContract) // TODO: change back to flower address once getFlowerBalance is fixed
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
    
    func handlePollinate(flower: Flower, transactionState: Binding<TransactionState>) async throws -> [String] {
        let hiveAddress = Constants.Networks.BaseSepolia.Honeycomb.hiveContract
        var transactionHashes: [String] = []

        // Approve USDC
        let usdcAmount: BigUInt = 1000000 // 1 USDC
        transactionState.wrappedValue = .checkingApproval        
        let approvalResponse = try await HiveManager.shared.approveUSDC(spenderAddress: hiveAddress, amount: usdcAmount)
        transactionHashes.append(approvalResponse)
        
        // Deposit to Hive
        transactionState.wrappedValue = .depositingToHive
        let depositResponse = try await HiveManager.shared.depositToHive(hiveAddress: hiveAddress, amount: usdcAmount)
        transactionHashes.append(depositResponse)

        // Pollinate
        transactionState.wrappedValue = .pollinatingFlower
        let pollinateResponse = try await HiveManager.shared.pollinate(flowerAddress: flower.contract)
        transactionHashes.append(pollinateResponse)

        return transactionHashes
    }

    func handleHarvest(flower: Flower) async throws -> [String] {
        let harvestResponse = try await HiveManager.shared.harvest(flowerAddress: flower.contract)
        return [harvestResponse]
    }
}
