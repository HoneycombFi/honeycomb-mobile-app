import Foundation
import web3swift
import Web3Core

class NetworkManager {
    static let shared = NetworkManager()

    private var web3: Web3?

    private init() {}

    func getProvider() async throws -> Web3 {
        if let web3 = self.web3 {
            return web3
        }

        let url = URL(string: ConfigManager.shared.rpcURL)!
        let web3Provider = try await Web3HttpProvider(url: url, network: Networks.Custom(networkID: 84532))
        let web3 = Web3(provider: web3Provider)
        self.web3 = web3
        return web3
    }

    func getNetwork() async throws -> Web3 {
        return try await getProvider()
    }

    func pollTransactionStatus(transactionHash: String) async throws -> TransactionReceipt {
        let web3 = try await getProvider()
        guard let txHashData = Data.fromHex(transactionHash) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid transaction hash"])
        }
        let receipt = try await TransactionPollingTask(transactionHash: txHashData, web3Instance: web3).wait()
        return receipt
    }
}
