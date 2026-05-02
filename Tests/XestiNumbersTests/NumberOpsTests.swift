// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberOpsTests {
}

// MARK: -

extension NumberOpsTests {
    @Test
    func test_addition() {
        #expect(Number(2) + Number(3) == Number(5))
        #expect(Number(-1) + Number(1) == Number(0))
        #expect(Number(0) + Number(0) == Number(0))

        let floatResult = Number(1.5) + Number(2.5)

        #expect(floatResult.doubleValue.isApproximatelyEqual(to: 4.0))

        let mixed = Number(1) + Number(0.5)

        #expect(mixed.doubleValue.isApproximatelyEqual(to: 1.5))
    }

    @Test
    func test_addition_assignment() {
        var n = Number(10)

        n += Number(5)

        #expect(n == Number(15))
    }

    @Test
    func test_bitwiseAnd() {
        #expect((Number(0b1100) & Number(0b1010)) == Number(0b1000))
        #expect((Number(0xFF) & Number(0x0F)) == Number(0x0F))
    }

    @Test
    func test_bitwiseAnd_assignment() {
        var n = Number(0b1100)

        n &= Number(0b1010)

        #expect(n == Number(0b1000))
    }

    @Test
    func test_bitwiseNot() {
        let n = Number(0)

        #expect(~n == Number(-1))

        let m = Number(5)

        #expect(~m == Number(-6))
    }

    @Test
    func test_bitwiseOr() {
        #expect((Number(0b1100) | Number(0b1010)) == Number(0b1110))
        #expect((Number(0) | Number(0xFF)) == Number(0xFF))
    }

    @Test
    func test_bitwiseOr_assignment() {
        var n = Number(0b1100)

        n |= Number(0b1010)

        #expect(n == Number(0b1110))
    }

    @Test
    func test_bitwiseXor() {
        #expect((Number(0b1100) ^ Number(0b1010)) == Number(0b0110))
        #expect((Number(0xFF) ^ Number(0xFF)) == Number(0))
    }

    @Test
    func test_bitwiseXor_assignment() {
        var n = Number(0b1100)

        n ^= Number(0b1010)

        #expect(n == Number(0b0110))
    }

    @Test
    func test_division() {
        #expect(Number(10) / Number(2) == Number(5))
        #expect(Number(7) / Number(2) == Number(numerator: 7, denominator: 2))

        let floatResult = Number(7.0) / Number(2.0)

        #expect(floatResult.doubleValue.isApproximatelyEqual(to: 3.5))
    }

    @Test
    func test_division_assignment() {
        var n = Number(10)

        n /= Number(2)

        #expect(n == Number(5))
    }

    @Test
    func test_multiplication() {
        #expect(Number(3) * Number(4) == Number(12))
        #expect(Number(-2) * Number(3) == Number(-6))
        #expect(Number(0) * Number(100) == Number(0))

        let floatResult = Number(2.5) * Number(4.0)

        #expect(floatResult.doubleValue.isApproximatelyEqual(to: 10.0))
    }

    @Test
    func test_multiplication_assignment() {
        var n = Number(3)

        n *= Number(4)

        #expect(n == Number(12))
    }

    @Test
    func test_negation() {
        #expect(-Number(5) == Number(-5))
        #expect(-Number(-3) == Number(3))
        #expect(-Number(0) == Number(0))

        let floatNeg = -Number(2.5)

        #expect(floatNeg.doubleValue.isApproximatelyEqual(to: -2.5))
    }

    @Test
    func test_shiftLeft() {
        #expect((Number(1) << 3) == Number(8))
        #expect((Number(5) << 1) == Number(10))
    }

    @Test
    func test_shiftLeft_assignment() {
        var n = Number(1)

        n <<= 4

        #expect(n == Number(16))
    }

    @Test
    func test_shiftRight() {
        #expect((Number(8) >> 3) == Number(1))
        #expect((Number(16) >> 2) == Number(4))
    }

    @Test
    func test_shiftRight_assignment() {
        var n = Number(16)

        n >>= 2

        #expect(n == Number(4))
    }

    @Test
    func test_subtraction() {
        #expect(Number(5) - Number(3) == Number(2))
        #expect(Number(3) - Number(5) == Number(-2))
        #expect(Number(0) - Number(0) == Number(0))

        let floatResult = Number(5.5) - Number(2.5)

        #expect(floatResult.doubleValue.isApproximatelyEqual(to: 3.0))
    }

    @Test
    func test_subtraction_assignment() {
        var n = Number(10)

        n -= Number(3)

        #expect(n == Number(7))
    }
}
