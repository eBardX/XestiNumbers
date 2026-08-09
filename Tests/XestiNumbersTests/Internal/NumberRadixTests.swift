// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberRadixTests {
}

// MARK: -

extension NumberRadixTests {
    @Test
    func init_rawValue() {
        #expect(Number.Radix(rawValue: 2) == .binary)
        #expect(Number.Radix(rawValue: 8) == .octal)
        #expect(Number.Radix(rawValue: 10) == .decimal)
        #expect(Number.Radix(rawValue: 16) == .hexadecimal)
        #expect(Number.Radix(rawValue: 5) == nil)
    }

    @Test
    func rawValue() {
        #expect(Number.Radix.binary.rawValue == 2)
        #expect(Number.Radix.octal.rawValue == 8)
        #expect(Number.Radix.decimal.rawValue == 10)
        #expect(Number.Radix.hexadecimal.rawValue == 16)
    }
}
