import Foundation
import web3swift
import Web3Core
import BigInt

class HiveManager {
    static let shared = HiveManager()

    private init() {}

    func getFlowerBalance(userAddress: String, flowerAddress: String) async throws -> String {
        do {
            let web3 = try await NetworkManager.shared.getNetwork()
            guard let ethAddress = EthereumAddress(userAddress), let contractAddress = EthereumAddress(flowerAddress) else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Ethereum address"])
            }
            let contract = web3.contract(Web3.Utils.erc20ABI, at: contractAddress, abiVersion: 2)!
            guard let readTX = contract.createReadOperation("balanceOf", parameters: [ethAddress]) else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create read operation"])
            }
            let tokenBalanceResponse = try await readTX.callContractMethod()
            guard let tokenBalance = tokenBalanceResponse["0"] as? BigUInt else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get token balance"])
            }
            let formattedTokenBalance = Web3Core.Utilities.formatToPrecision(tokenBalance, formattingDecimals: 6)
            return formattedTokenBalance
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch token balance: \(error.localizedDescription)"])
        }
    }
}
