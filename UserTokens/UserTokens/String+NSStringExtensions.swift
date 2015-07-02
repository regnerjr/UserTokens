import Foundation

extension NSString {
    var containsDecimal: Bool {
        let decimals = NSCharacterSet.decimalDigitCharacterSet()
        let parts = self.componentsSeparatedByCharactersInSet(decimals)
        return parts.count > 1
    }
}

extension String {
    var longerThanEightChars: Bool {
        return self.utf16.count > 8
    }
}
