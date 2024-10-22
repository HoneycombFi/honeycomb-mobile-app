import Foundation

class ConfigManager {
    static let shared = ConfigManager()
    
    private init() {}
    
    var rpcURL: String {
        return ProcessInfo.processInfo.environment["RPC_URL"] ?? "https://sepolia.base.org"
    }
    
    var infuraToken: String {
        return ProcessInfo.processInfo.environment["INFURA_TOKEN"] ?? ""
    }
}
