import Foundation
import web3swift
import Web3Core
import BigInt

class WalletManager {
    static let shared = WalletManager()

    private init() {}

    private var priceCache: [String: (price: Double, timestamp: Date)] = [:]
    private var balanceCache: [String: (balance: String, timestamp: Date)] = [:]
    private let cacheDuration: TimeInterval = 60 // Cache duration in seconds

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

    func getETHBalance(address: String) async throws -> String {
        if let cachedBalance = balanceCache[address], Date().timeIntervalSince(cachedBalance.timestamp) < cacheDuration {
            return cachedBalance.balance
        }

        do {
            let web3 = try await NetworkManager.shared.getNetwork()
            guard let ethAddress = EthereumAddress(address) else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Ethereum address"])
            }
            let balanceResult = try await web3.eth.getBalance(for: ethAddress)
            let balanceInEther = Web3Core.Utilities.formatToPrecision(balanceResult, formattingDecimals: 6)
            
            balanceCache[address] = (balance: balanceInEther, timestamp: Date())
            
            return balanceInEther
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch ETH balance: \(error.localizedDescription)"])
        }
    }

    func getERC20TokenBalance(address: String, contractAddress: String) async throws -> String {
        let cacheKey = "\(address)_\(contractAddress)"
                
        if let cachedBalance = balanceCache[cacheKey], Date().timeIntervalSince(cachedBalance.timestamp) < cacheDuration {
            return cachedBalance.balance
        }

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
                        
            if tokenBalanceResponse.isEmpty {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response from contract"])
            }
            
            guard let tokenBalance = tokenBalanceResponse["0"] as? BigUInt else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get token balance"])
            }
            
            let formattedTokenBalance = Web3Core.Utilities.formatToPrecision(tokenBalance, formattingDecimals: 6)
            
            balanceCache[cacheKey] = (balance: formattedTokenBalance, timestamp: Date())
            
            return formattedTokenBalance
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch token balance: \(error.localizedDescription)"])
        }
    }

    func getTokenPriceUSD(tokenId: String) async throws -> Double {
        if let cachedPrice = priceCache[tokenId], Date().timeIntervalSince(cachedPrice.timestamp) < cacheDuration {
            return cachedPrice.price
        }
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(tokenId)&vs_currencies=usd"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch token price, status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)"])
        }
        
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        guard let tokenData = json?[tokenId] as? [String: Any], let usdPrice = tokenData["usd"] as? Double else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid data format"])
        }
        
        priceCache[tokenId] = (price: usdPrice, timestamp: Date())
        
        return usdPrice
    }
}
