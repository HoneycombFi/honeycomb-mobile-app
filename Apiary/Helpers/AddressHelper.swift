import Foundation

class AddressHelper {
    static let shared = AddressHelper()

    private init() {}

    func formatAddress(_ address: String) -> String {
        guard address.count > 10 else { return address }
        let start = address.prefix(6)
        let end = address.suffix(4)
        return "\(start)...\(end)"
    }
    
    // TODO: ENS resolution
}
