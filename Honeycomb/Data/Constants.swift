import Foundation

struct Constants {
    struct Network {
        static let base = "Base"
        static let baseSepolia = "BaseSepolia"
    }

    struct ContractAddresses {
        struct Base {
            static let hiveContract = "0x1234567890abcdef1234567890abcdef12345678"
            static let synthetixFlower = "0xabcdefabcdefabcdefabcdefabcdefabcdefabcd"
            static let panopticFlower = "0xabcdefabcdefabcdefabcdefabcdefabcdefabce"
            static let aerodromeFlower = "0xabcdefabcdefabcdefabcdefabcdefabcdefabcf"
            static let beefyFlower = "0xabcdefabcdefabcdefabcdefabcdefabcdefabcg"
        }
        
        struct BaseSepolia {
            static let hiveContract = "0x7219cECaA0923dDfE7cDB3b782Aff7a69A2Ae478"
            static let synthetixFlower = "0xabcdefabcdefabcdefabcdefabcdefabcdefabce"
            static let panopticFlower = "0xabcdefabcdefabcdefabcdefabcdefabcdefabcf"
            static let aerodromeFlower = "0xabcdefabcdefabcdefabcdefabcdefabcdefabcg"
            static let beefyFlower = "0xabcdefabcdefabcdefabcdefabcdefabcdefabch"
            static let usdcToken = "0xD4fA4dE9D8F8DB39EAf4de9A19bF6910F6B5bD60"
        }
    }

    struct StaticValues {
        struct Base {
            static let maxDepositAmount = 100_000.0
            static let minDepositAmount = 1.0
            static let pollinationFee = 0.05
            static let harvestFee = 0.1
        }
        
        struct BaseSepolia {
            static let maxDepositAmount = 100_000.0
            static let minDepositAmount = 1.0
            static let pollinationFee = 0.05
            static let harvestFee = 0.1
        }
    }
}
