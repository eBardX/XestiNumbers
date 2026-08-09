// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberParseTests {
}

// MARK: -

extension NumberParseTests {
    @Test
    func parse_binaryPrefix() {
        #expect(Number.parse(input: "#b101010") == Number(42))
    }

    @Test
    func parse_decimalPrefix() {
        #expect(Number.parse(input: "#d42") == Number(42))
    }

    @Test
    func parse_doubleExactnessPrefix() {
        #expect(Number.parse(input: "#e#i42") == nil)
    }

    @Test
    func parse_doubleRadixPrefix() {
        #expect(Number.parse(input: "#b#d42") == nil)
    }

    @Test
    func parse_exactPrefix() {
        #expect(Number.parse(input: "#e42")?.isExact == true)
    }

    @Test
    func parse_hexadecimalPrefix() {
        #expect(Number.parse(input: "#x2a") == Number(42))
    }

    @Test
    func parse_inexactPrefix() {
        #expect(Number.parse(input: "#i42")?.isExact == false)
    }

    @Test
    func parse_invalidInput() {
        #expect(Number.parse(input: "not a number") == nil)
    }

    @Test
    func parse_noPrefix() {
        #expect(Number.parse(input: "42") == Number(42))
        #expect(Number.parse(input: "3.14")?.doubleValue.isApproximatelyEqual(to: 3.14) == true)
        #expect(Number.parse(input: "3/4") == Number(numerator: 3, denominator: 4))
    }

    @Test
    func parse_octalPrefix() {
        #expect(Number.parse(input: "#o52") == Number(42))
    }

    @Test
    func parse_radix_exactness() {
        #expect(Number.parse(input: "42", radix: .decimal, exactness: .unspecified) == Number(42))
        #expect(Number.parse(input: "xyz", radix: .decimal, exactness: .unspecified) == nil)
    }
}
