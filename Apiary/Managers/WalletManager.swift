import Foundation
import web3swift
import Web3Core

class WalletManager {
    static let shared = WalletController()
    
    private init() {}
    
    func createWallet() throws -> String {
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
}
