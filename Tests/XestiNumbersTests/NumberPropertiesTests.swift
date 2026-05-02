// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberPropertiesTests {
}

// MARK: -

extension NumberPropertiesTests {
    @Test
    func test_angle() {
        let positive = Number(1)

        #expect(positive.angle == Number(0))

        let negative = Number(-1)

        #expect(negative.angle.doubleValue.isApproximatelyEqual(to: Double.pi))

        let complex = Number(realPart: Number(0), imaginaryPart: Number(1))

        #expect(complex.angle.doubleValue.isApproximatelyEqual(to: Double.pi / 2))
    }

    @Test
    func test_denominator() {
        let integer = Number(5)

        #expect(integer.denominator == Number(1))

        let fraction = Number(numerator: 3, denominator: 4)

        #expect(fraction.denominator == Number(4))
    }

    @Test
    func test_exact() {
        let inexact = Number(3.14)

        #expect(inexact.isInexact)

        let exact = inexact.exact

        #expect(exact.isExact)
    }

    @Test
    func test_imaginaryPart() {
        let real = Number(5)

        #expect(real.imaginaryPart == Number(0))

        let complex = Number(realPart: Number(3), imaginaryPart: Number(4))

        #expect(complex.imaginaryPart == Number(4))
    }

    @Test
    func test_inexact() {
        let exact = Number(42)

        #expect(exact.isExact)

        let inexact = exact.inexact

        #expect(inexact.isInexact)
        #expect(inexact.doubleValue.isApproximatelyEqual(to: 42.0))
    }

    @Test
    func test_isComplex() {
        #expect(Number(42).isComplex)
        #expect(Number(3.14).isComplex)
        #expect(Number(realPart: Number(1), imaginaryPart: Number(2)).isComplex)
    }

    @Test
    func test_isEven() {
        #expect(Number(4).isEven)
        #expect(Number(0).isEven)
        #expect(!Number(3).isEven)
    }

    @Test
    func test_isExact() {
        #expect(Number(42).isExact)
        #expect(!Number(3.14).isExact)
    }

    @Test
    func test_isFinite() {
        #expect(Number(42).isFinite)
        #expect(Number(3.14).isFinite)
        #expect(!Number.positiveInfinity.isFinite)
        #expect(!Number.negativeInfinity.isFinite)
    }

    @Test
    func test_isInexact() {
        #expect(!Number(42).isInexact)
        #expect(Number(3.14).isInexact)
    }

    @Test
    func test_isInfinite() {
        #expect(Number.positiveInfinity.isInfinite)
        #expect(Number.negativeInfinity.isInfinite)
        #expect(!Number(42).isInfinite)
    }

    @Test
    func test_isInteger() {
        #expect(Number(42).isInteger)
        #expect(!Number(numerator: 3, denominator: 4).isInteger)
        #expect(!Number(3.14).isInteger)
    }

    @Test
    func test_isNaN() {
        #expect(Number.nan.isNaN)
        #expect(!Number(42).isNaN)
    }

    @Test
    func test_isNegative() {
        #expect(Number(-5).isNegative)
        #expect(!Number(5).isNegative)
        #expect(!Number(0).isNegative)
    }

    @Test
    func test_isOdd() {
        #expect(Number(3).isOdd)
        #expect(Number(7).isOdd)
        #expect(!Number(4).isOdd)
        #expect(!Number(0).isOdd)
    }

    @Test
    func test_isPositive() {
        #expect(Number(5).isPositive)
        #expect(!Number(-5).isPositive)
        #expect(!Number(0).isPositive)
    }

    @Test
    func test_isRational() {
        #expect(Number(42).isRational)
        #expect(Number(numerator: 3, denominator: 4).isRational)
        #expect(!Number.nan.isRational)
        #expect(!Number.positiveInfinity.isRational)
    }

    @Test
    func test_isReal() {
        #expect(Number(42).isReal)
        #expect(Number(3.14).isReal)

        let complex = Number(realPart: Number(1), imaginaryPart: Number(2))

        #expect(!complex.isReal)
    }

    @Test
    func test_isZero() {
        #expect(Number(0).isZero)
        #expect(!Number(1).isZero)
        #expect(!Number(-1).isZero)
    }

    @Test
    func test_magnitude() {
        #expect(Number(5).magnitude == Number(5))
        #expect(Number(-5).magnitude == Number(5))

        let complex = Number(realPart: Number(3), imaginaryPart: Number(4))

        #expect(complex.magnitude.doubleValue.isApproximatelyEqual(to: 5.0))
    }

    @Test
    func test_numerator() {
        let integer = Number(5)

        #expect(integer.numerator == Number(5))

        let fraction = Number(numerator: 3, denominator: 4)

        #expect(fraction.numerator == Number(3))
    }

    @Test
    func test_realPart() {
        let real = Number(5)

        #expect(real.realPart == Number(5))

        let complex = Number(realPart: Number(3), imaginaryPart: Number(4))

        #expect(complex.realPart == Number(3))
    }

    @Test
    func test_simplified() {
        let fraction = Number(numerator: 4, denominator: 4)
        let simplified = fraction.simplified

        #expect(simplified.isInteger)
        #expect(simplified == Number(1))
    }
}
