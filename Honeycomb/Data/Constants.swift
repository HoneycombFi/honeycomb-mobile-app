import Foundation

struct Constants {
    
    struct Globals {
        static let maxDepositAmount = 100_000.0
        static let minDepositAmount = 1.0
        static let pollinationFee = 0.005
        static let harvestFee = 0.01
    }

    struct Networks {
        
        // MAINNET
        struct Base {
            struct Honeycomb {
                static let hiveContract = "0xab38a1fdfbe9d456457416fae7f0ef7696e59293"
            }

            struct Flowers {
                static let synthetixFlower = Flower(contract: "0xD8AD8237152B4d29CBca9B584b8a1Ae054A7F0d6", name: "Synthetix Flower", logo: "synthetix", info: "Some description of the flower here.")
                static let panopticFlower = Flower(contract: "0xA214eB62888F3FeBFC454e2919c7630F27c30C1b", name: "Panoptic Flower", logo: "panoptic", info: "Some description of the flower here.")

                static let all: [Flower] = [
                    synthetixFlower,
                    panopticFlower
                ]
            }

            struct Tokens {
                static let usdcToken = "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913"
                static let WETH = "0x4200000000000000000000000000000000000006"
            }
        }

        // TESTNET
        struct BaseSepolia {
            struct Honeycomb {
                static let hiveContract = "0xc5780188522E125177B6c03625204d0aA832D440"
            }

            struct Flowers {
                static let synthetixFlower = Flower(contract: "0xA214eB62888F3FeBFC454e2919c7630F27c30C1b", name: "Synthetix Flower", logo: "synthetix", info: "Some description of the flower here.")
                static let aerodromeFlower = Flower(contract: "0x5058E52aC4eF3638cc5ad33D1c709f3411A8A82f", name: "Aerodrome Flower", logo: "aerodrome", info: "Some description of the flower here.")
                static let panopticFlower = Flower(contract: "0x5058E52aC4eF3638cc5ad33D1c709f3411A8A82f", name: "Panoptic Flower", logo: "panoptic", info: "Some description of the flower here.")
                static let beefyFlower = Flower(contract: "0x5058E52aC4eF3638cc5ad33D1c709f3411A8A82f", name: "Beefy Flower", logo: "beefy", info: "Some description of the flower here.")

                static let all: [Flower] = [
                    synthetixFlower,
                    aerodromeFlower,
                    panopticFlower,
                    beefyFlower
                ]
            }

            struct Tokens {
                static let usdcToken = "0x036CbD53842c5426634e7929541eC2318f3dCF7e"
                static let WETH = "0x4200000000000000000000000000000000000006"
            }
        }
    }
}
