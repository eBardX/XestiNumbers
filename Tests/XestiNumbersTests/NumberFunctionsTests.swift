// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberFunctionsTests {
}

// MARK: -

extension NumberFunctionsTests {
    @Test
    func test_abs() {
        #expect(XestiNumbers.abs(Number(5)) == Number(5))
        #expect(XestiNumbers.abs(Number(-5)) == Number(5))
        #expect(XestiNumbers.abs(Number(0)) == Number(0))
    }

    @Test
    func test_acos() {
        let result = XestiNumbers.acos(Number(1.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_asin() {
        let result = XestiNumbers.asin(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_atan() {
        let result = XestiNumbers.atan(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_atan2() {
        let result = XestiNumbers.atan(Number(1.0), Number(1.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: Double.pi / 4))
    }

    @Test
    func test_ceiling() {
        let fraction = Number(numerator: 7, denominator: 2)

        #expect(XestiNumbers.ceiling(fraction) == Number(4))

        let floatVal = Number(3.2)

        #expect(XestiNumbers.ceiling(floatVal).doubleValue.isApproximatelyEqual(to: 4.0))

        #expect(XestiNumbers.ceiling(Number(5)) == Number(5))
    }

    @Test
    func test_cos() {
        let result = XestiNumbers.cos(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 1.0))
    }

    @Test
    func test_exp() {
        let result0 = XestiNumbers.exp(Number(0.0))

        #expect(result0.doubleValue.isApproximatelyEqual(to: 1.0))

        let result1 = XestiNumbers.exp(Number(1.0))

        #expect(result1.doubleValue.isApproximatelyEqual(to: Foundation.exp(1.0)))
    }

    @Test
    func test_floor() {
        let fraction = Number(numerator: 7, denominator: 2)

        #expect(XestiNumbers.floor(fraction) == Number(3))

        let floatVal = Number(3.8)

        #expect(XestiNumbers.floor(floatVal).doubleValue.isApproximatelyEqual(to: 3.0))

        #expect(XestiNumbers.floor(Number(5)) == Number(5))
    }

    @Test
    func test_gcd() {
        #expect(XestiNumbers.gcd(Number(12), Number(8)) == Number(4))
        #expect(XestiNumbers.gcd(Number(15), Number(10)) == Number(5))
        #expect(XestiNumbers.gcd(Number(7), Number(3)) == Number(1))
    }

    @Test
    func test_lcm() {
        #expect(XestiNumbers.lcm(Number(4), Number(6)) == Number(12))
        #expect(XestiNumbers.lcm(Number(3), Number(5)) == Number(15))
    }

    @Test
    func test_log() {
        let result = XestiNumbers.log(Number(1.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_max() {
        #expect(XestiNumbers.max(Number(3), Number(5)) == Number(5))
        #expect(XestiNumbers.max(Number(5), Number(3)) == Number(5))
        #expect(XestiNumbers.max(Number(4), Number(4)) == Number(4))
    }

    @Test
    func test_min() {
        #expect(XestiNumbers.min(Number(3), Number(5)) == Number(3))
        #expect(XestiNumbers.min(Number(5), Number(3)) == Number(3))
        #expect(XestiNumbers.min(Number(4), Number(4)) == Number(4))
    }

    @Test
    func test_modulo() {
        #expect(XestiNumbers.modulo(Number(13), Number(4)) == Number(1))
        #expect(XestiNumbers.modulo(Number(-13), Number(4)) == Number(3))
        #expect(XestiNumbers.modulo(Number(13), Number(-4)) == Number(-3))
        #expect(XestiNumbers.modulo(Number(-13), Number(-4)) == Number(-1))
    }

    @Test
    func test_quotient() {
        #expect(XestiNumbers.quotient(Number(7), Number(2)) == Number(3))
        #expect(XestiNumbers.quotient(Number(10), Number(3)) == Number(3))
    }

    @Test
    func test_remainder() {
        #expect(XestiNumbers.remainder(Number(7), Number(2)) == Number(1))
        #expect(XestiNumbers.remainder(Number(-7), Number(2)) == Number(-1))
        #expect(XestiNumbers.remainder(Number(7), Number(-2)) == Number(1))
    }

    @Test
    func test_round() {
        let result = XestiNumbers.round(Number(numerator: 7, denominator: 2))

        #expect(result == Number(4))

        #expect(XestiNumbers.round(Number(numerator: 5, denominator: 2)) == Number(2))
    }

    @Test
    func test_sin() {
        let result = XestiNumbers.sin(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_sqrt() {
        #expect(XestiNumbers.sqrt(Number(4.0)).doubleValue.isApproximatelyEqual(to: 2.0))
        #expect(XestiNumbers.sqrt(Number(9.0)).doubleValue.isApproximatelyEqual(to: 3.0))
        #expect(XestiNumbers.sqrt(Number(0.0)).doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_tan() {
        let result = XestiNumbers.tan(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_truncate() {
        let fraction = Number(numerator: 7, denominator: 2)

        #expect(XestiNumbers.truncate(fraction) == Number(3))

        let negative = Number(numerator: -7, denominator: 2)

        #expect(XestiNumbers.truncate(negative) == Number(-3))
    }
}
