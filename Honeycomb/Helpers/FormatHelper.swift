import Foundation

class FormatHelper {
    /// Trims trailing zeros from a decimal number string.
    ///
    /// - Parameter numberString: The string representation of the number.
    /// - Returns: The formatted string with trailing zeros removed.
    static func trimTrailingZeroes(from numberString: String) -> String {
        guard numberString.contains(".") else { return numberString }
        
        let parts = numberString.split(separator: ".")
        
        guard parts.count == 2 else { return numberString }
        
        let integerPart = String(parts[0])
        var fractionalPart = String(parts[1])
        
        while fractionalPart.last == "0" {
            fractionalPart.removeLast()
        }
        
        if fractionalPart.isEmpty {
            return integerPart
        }
        
        return "\(integerPart).\(fractionalPart)"
    }
}
