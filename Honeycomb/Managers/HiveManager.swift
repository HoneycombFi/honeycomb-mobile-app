import Foundation
import web3swift
import Web3Core
import BigInt

class HiveManager {
    static let shared = HiveManager()

    private init() {}

    private var balanceCache: [String: (balance: String, timestamp: Date)] = [:]
    private var yieldCache: [String: (yield: Double, timestamp: Date)] = [:]
    private let balanceCacheDuration: TimeInterval = 60
    private let yieldCacheDuration: TimeInterval = 15 * 60
    
    // Views

    func getFlowerBalance(userAddress: String, flowerAddress: String) async throws -> String {
        let cacheKey = "\(userAddress)_\(flowerAddress)"
        
        if let cachedBalance = balanceCache[cacheKey], Date().timeIntervalSince(cachedBalance.timestamp) < balanceCacheDuration {
            return cachedBalance.balance
        }

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
            print("Formatted Token Balance: \(formattedTokenBalance)")

            balanceCache[cacheKey] = (balance: formattedTokenBalance, timestamp: Date())
            return formattedTokenBalance
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch token balance: \(error.localizedDescription)"])
        }
    }

    func getFlowerYield(flowerAddress: String) async -> Double {
        let cacheKey = flowerAddress

        if let cachedYield = yieldCache[cacheKey], Date().timeIntervalSince(cachedYield.timestamp) < yieldCacheDuration {
            return cachedYield.yield
        }

        let yield = Double.random(in: 10...50)
        yieldCache[cacheKey] = (yield: yield, timestamp: Date())
        return yield
    }

    func getAllowance(tokenAddress: String, spenderAddress: String, ownerAddress: String) async throws -> BigUInt {
        let web3 = try await NetworkManager.shared.getNetwork()
        guard let owner = EthereumAddress(ownerAddress), let spender = EthereumAddress(spenderAddress) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Ethereum address"])
        }
        guard let contractAddress = EthereumAddress(tokenAddress) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Contract address"])
        }
        let contract = web3.contract(Web3.Utils.erc20ABI, at: contractAddress, abiVersion: 2)!
        guard let readTX = contract.createReadOperation("allowance", parameters: [owner, spender]) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create read operation"])
        }
        let allowanceResponse = try await readTX.callContractMethod()
        guard let allowance = allowanceResponse["0"] as? BigUInt else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get allowance"])
        }
        return allowance
    }
    
    // Mutative

    func approveUSDC(spenderAddress: String, amount: BigUInt) async throws -> String {
        let (keystore, ethAddress) = try loadKeystore()
        let web3 = try await NetworkManager.shared.getProvider()
        web3.addKeystoreManager(KeystoreManager([keystore]))

        guard let spender = EthereumAddress(spenderAddress) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Ethereum address"])
        }
        let usdcAddress = Constants.Networks.BaseSepolia.Tokens.usdcToken
        guard let contractAddress = EthereumAddress(usdcAddress) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid USDC contract address"])
        }
        let currentAllowance = try await getAllowance(tokenAddress: usdcAddress, spenderAddress: spenderAddress, ownerAddress: ethAddress.address)
                
        if currentAllowance >= amount {
            print("no need to approve, sufficient allowance available")
            return "No need to approve, sufficient allowance available"
        }
        
        let contract = web3.contract(Web3.Utils.erc20ABI, at: contractAddress, abiVersion: 2)!
        let writeTX = contract.createWriteOperation("approve", parameters: [spender, amount])!
        writeTX.transaction.from = ethAddress
        writeTX.transaction.chainID = BigUInt(84532)

        let policies = Policies(gasLimitPolicy: .automatic)
        let result = try await writeTX.writeToChain(password: "", policies: policies, sendRaw: true)
        return result.hash
    }

    func depositToHive(hiveAddress: String, amount: BigUInt) async throws -> String {
        let (keystore, ethAddress) = try loadKeystore()
        let web3 = try await NetworkManager.shared.getProvider()
        web3.addKeystoreManager(KeystoreManager([keystore]))

        guard let hive = EthereumAddress(hiveAddress) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Ethereum address"])
        }
        let contract = web3.contract(ABI.HiveABI, at: hive, abiVersion: 2)!
        let writeTX = contract.createWriteOperation("deposit", parameters: [amount, ethAddress])!
        writeTX.transaction.from = ethAddress
        writeTX.transaction.chainID = BigUInt(84532)

        let policies = Policies(gasLimitPolicy: .automatic)
        let result = try await writeTX.writeToChain(password: "", policies: policies, sendRaw: false)
        return result.hash
    }

    func pollinate(flowerAddress: String) async throws -> String {
        let (keystore, ethAddress) = try loadKeystore()
        let web3 = try await NetworkManager.shared.getProvider()
        web3.addKeystoreManager(KeystoreManager([keystore]))

        guard let contractAddress = EthereumAddress(flowerAddress) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Ethereum address"])
        }
        let contract = web3.contract(ABI.HiveABI, at: contractAddress, abiVersion: 2)!
        let writeTX = contract.createWriteOperation("pollinate", parameters: [ethAddress])!
        writeTX.transaction.from = ethAddress
        writeTX.transaction.chainID = BigUInt(84532)

        let policies = Policies(gasLimitPolicy: .automatic)
        let result = try await writeTX.writeToChain(password: "", policies: policies, sendRaw: false)
        return result.hash
    }

    func harvest(flowerAddress: String) async throws -> String {
        let (keystore, ethAddress) = try loadKeystore()
        let web3 = try await NetworkManager.shared.getProvider()
        web3.addKeystoreManager(KeystoreManager([keystore]))

        guard let contractAddress = EthereumAddress(flowerAddress) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Ethereum address"])
        }
        let contract = web3.contract(ABI.HiveABI, at: contractAddress, abiVersion: 2)!
        let writeTX = contract.createWriteOperation("harvest", parameters: [ethAddress])!
        writeTX.transaction.from = ethAddress
        writeTX.transaction.chainID = BigUInt(84532)

        let policies = Policies(gasLimitPolicy: .automatic)
        let result = try await writeTX.writeToChain(password: "", policies: policies, sendRaw: false)
        return result.hash
    }
    
    // Restricted
    
    private func loadKeystore() throws -> (keystore: BIP32Keystore, address: EthereumAddress) {
        guard let mnemonics = KeychainHelper.shared.get("mnemonics") else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mnemonics not found in keychain"])
        }
        
        let keystore = try BIP32Keystore(mnemonics: mnemonics, password: "")
        guard let address = keystore?.addresses?.first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to generate address from mnemonics"])
        }
        return (keystore!, address)
    }
}
