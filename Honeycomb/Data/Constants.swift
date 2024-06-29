import Foundation

struct Constants {
    
    struct Globals {
        static let maxDepositAmount = 100_000.0
        static let minDepositAmount = 1.0
        static let pollinationFee = 0.05
        static let harvestFee = 0.1
    }

    struct Networks {
        struct Base {}

        struct BaseSepolia {
            struct HoneyComb {
                static let hiveContract = "0x7219cECaA0923dDfE7cDB3b782Aff7a69A2Ae478"
            }

            struct Flowers {
                static let synthetixFlower = Flower(contract: "0x7219cECaA0923dDfE7cDB3b782Aff7a69A2Ae478", name: "Synthetix Flower", logo: "synthetix", info: "Some description of the flower here.")
                static let aerodromeFlower = Flower(contract: "0x7219cECaA0923dDfE7cDB3b782Aff7a69A2Ae478", name: "Aerodrome Flower", logo: "aerodrome", info: "Some description of the flower here.")
                static let panopticFlower = Flower(contract: "0x7219cECaA0923dDfE7cDB3b782Aff7a69A2Ae478", name: "Panoptic Flower", logo: "panoptic", info: "Some description of the flower here.")
                static let beefyFlower = Flower(contract: "0x7219cECaA0923dDfE7cDB3b782Aff7a69A2Ae478", name: "Beefy Flower", logo: "beefy", info: "Some description of the flower here.")

                static let all: [Flower] = [
                    synthetixFlower,
                    aerodromeFlower,
                    panopticFlower,
                    beefyFlower
                ]
            }

            struct Tokens {
                static let usdcToken = "0xD4fA4dE9D8F8DB39EAf4de9A19bF6910F6B5bD60"
            }
        }
    }
}
