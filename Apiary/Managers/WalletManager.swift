import Foundation
import web3swift
import Web3Core
import BigInt

class WalletManager {
    static let shared = WalletManager()

    private init() {}

    func createWallet() async throws -> String {
        let mnemonics = try BIP39.generateMnemonics(bitsOfEntropy: 256)!
        let keystore = try BIP32Keystore(mnemonics: mnemonics, password: "", prefixPath: "m/44'/60'/0'/0")!
        let address = keystore.addresses!.first!.address
        saveToKeychain(address: address, mnemonics: mnemonics)
        UserDefaults.standard.set(address, forKey: "walletAddress")
        return address
    }

    private func saveToKeychain(address: String, mnemonics: String) {
        KeychainHelper.shared.save(address, for: "walletAddress")
        KeychainHelper.shared.save(mnemonics, for: "mnemonics")
    }

    func getSavedWalletAddress() -> String? {
        return UserDefaults.standard.string(forKey: "walletAddress")
    }

    func getETHBalance(address: String) async throws -> Double {
        do {
            let web3 = try await NetworkManager.shared.getNetwork()
            guard let ethAddress = EthereumAddress(address) else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Ethereum address"])
            }
            let balanceResult = try await web3.eth.getBalance(for: ethAddress)
            return Double(balanceResult)
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch ETH balance: \(error.localizedDescription)"])
        }
    }

    func getERC20TokenBalance(address: String, contractAddress: String) async throws -> Double {
        do {
            let web3 = try await NetworkManager.shared.getNetwork()
            guard let ethAddress = EthereumAddress(address), let contractAddress = EthereumAddress(contractAddress) else {
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
            return Double(tokenBalance)
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch token balance: \(error.localizedDescription)"])
        }
    }
}
