// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberInternalTests {
}

// MARK: -

extension NumberInternalTests {
    @Test
    func checkExactInteger() {
        #expect(Number(42).checkExactInteger().isEqual(to: ei(42)))
        #expect(Number(-7).checkExactInteger().isEqual(to: ei(-7)))

        let complexInt = Number(realPart: Number(42), imaginaryPart: Number(0))

        #expect(complexInt.checkExactInteger().isEqual(to: ei(42)))
    }

    @Test
    func checkInteger() {
        #expect(Number(42).checkInteger().isEqual(to: rei(42)))
        #expect(Number(4.0).checkInteger().isEqual(to: rfp(4.0)))

        let complexInt = Number(realPart: Number(42), imaginaryPart: Number(0))

        #expect(complexInt.checkInteger().isEqual(to: rei(42)))
    }

    @Test
    func checkRational() {
        let fraction = Number(numerator: 3, denominator: 4)

        #expect(fraction.checkRational().isEqual(to: rfr(3, 4)))
        #expect(Number(42).checkRational().isEqual(to: rei(42)))

        let complexRational = Number(realPart: fraction, imaginaryPart: Number(0))

        #expect(complexRational.checkRational().isEqual(to: rfr(3, 4)))
    }

    @Test
    func checkReal() {
        #expect(Number(42).checkReal().isEqual(to: rei(42)))

        let complexReal = Number(realPart: Number(42), imaginaryPart: Number(0))

        #expect(complexReal.checkReal().isEqual(to: rei(42)))
    }

    @Test
    func toComplex() {
        let realResult = Number(42).toComplex()

        #expect(realResult.testEqual(to: cx(42, 0)))

        let complexResult = Number(realPart: Number(3), imaginaryPart: Number(4)).toComplex()

        #expect(complexResult.testEqual(to: cx(3, 4)))
    }
}
