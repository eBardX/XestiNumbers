// © 2026 John Gary Pusey (see LICENSE.md)

@testable import XestiNumbers

internal struct TestNumberType: NumberRepresentable {
    internal static func isValid(_ numberValue: Number) -> Bool {
        numberValue.isInteger && !numberValue.isNegative
    }

    internal init?(numberValue: Number) {
        guard Self.isValid(numberValue)
        else { return nil }

        self.numberValue = numberValue
    }

    internal let numberValue: Number
}
