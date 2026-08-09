// © 2025–2026 John Gary Pusey (see LICENSE.md)

// swiftlint:disable file_length

import Testing
@testable import XestiNumbers
import XestiTools

struct RealTests {
}

// MARK: -

extension RealTests {
    @Test
    func absoluteValue() {
        #expect(rei(-5).absoluteValue().isEqual(to: rei(5)))
        #expect(rei(5).absoluteValue().isEqual(to: rei(5)))
        #expect(rei(0).absoluteValue().isEqual(to: rei(0)))
        #expect(rfp(-3.14).absoluteValue().isEqual(to: rfp(3.14)))
        #expect(rfp(3.14).absoluteValue().isEqual(to: rfp(3.14)))
        #expect(rfr(-3, 4).absoluteValue().isEqual(to: rfr(3, 4)))
        #expect(rfr(3, 4).absoluteValue().isEqual(to: rfr(3, 4)))
    }

    @Test
    func adding() {
        #expect(rei(3).adding(rei(4)).isEqual(to: rei(7)))
        #expect(rfp(1.5).adding(rfp(2.5)).isEqual(to: rfp(4.0)))
        #expect(rfr(1, 4).adding(rfr(1, 4)).isEqual(to: rfr(1, 2)))
        #expect(rei(1).adding(rfp(2.5)).isEqual(to: rfp(3.5)))
        #expect(rei(1).adding(rfr(1, 2)).isEqual(to: rfr(3, 2)))
    }

    @Test
    func angle() {
        #expect(rei(5).angle.isEqual(to: .exactZero))
        #expect(rei(-3).angle.isEqual(to: .pi))
        #expect(rfp(2.0).angle.isEqual(to: .inexactZero))
        #expect(rfp(-1.5).angle.isEqual(to: .pi))
        #expect(rfr(3, 4).angle.isEqual(to: .exactZero))
        #expect(rfr(-3, 4).angle.isEqual(to: .pi))
    }

    @Test
    func bitwiseAnd_with() {
        #expect(rei(12).bitwiseAnd(with: rei(10)).isEqual(to: rei(8)))
        #expect(rei(0xff).bitwiseAnd(with: rei(0x0f)).isEqual(to: rei(0x0f)))
        #expect(rei(0).bitwiseAnd(with: rei(0xff)).isEqual(to: rei(0)))
        #expect(rfp(12.0).bitwiseAnd(with: rfp(10.0)).isEqual(to: rfp(8.0)))
    }

    @Test
    func bitwiseNot() {
        #expect(rei(0).bitwiseNot().isEqual(to: rei(-1)))
        #expect(rei(-1).bitwiseNot().isEqual(to: rei(0)))
        #expect(rei(5).bitwiseNot().isEqual(to: rei(-6)))
        #expect(rfp(0.0).bitwiseNot().isEqual(to: rfp(-1.0)))
    }

    @Test
    func bitwiseOr_with() {
        #expect(rei(12).bitwiseOr(with: rei(10)).isEqual(to: rei(14)))
        #expect(rei(0).bitwiseOr(with: rei(0xff)).isEqual(to: rei(0xff)))
        #expect(rfp(12.0).bitwiseOr(with: rfp(10.0)).isEqual(to: rfp(14.0)))
    }

    @Test
    func bitwiseShiftLeft_bits() {
        #expect(rei(1).bitwiseShiftLeft(bits: 3).isEqual(to: rei(8)))
        #expect(rei(5).bitwiseShiftLeft(bits: 1).isEqual(to: rei(10)))
        #expect(rfp(1.0).bitwiseShiftLeft(bits: 3).isEqual(to: rfp(8.0)))
    }

    @Test
    func bitwiseShiftRight_bits() {
        #expect(rei(8).bitwiseShiftRight(bits: 3).isEqual(to: rei(1)))
        #expect(rei(10).bitwiseShiftRight(bits: 1).isEqual(to: rei(5)))
        #expect(rfp(8.0).bitwiseShiftRight(bits: 3).isEqual(to: rfp(1.0)))
    }

    @Test
    func bitwiseXor_with() {
        #expect(rei(12).bitwiseXor(with: rei(10)).isEqual(to: rei(6)))
        #expect(rei(0xff).bitwiseXor(with: rei(0xff)).isEqual(to: rei(0)))
        #expect(rfp(12.0).bitwiseXor(with: rfp(10.0)).isEqual(to: rfp(6.0)))
    }

    @Test
    func ceiling() {
        #expect(rei(3).ceiling().isEqual(to: rei(3)))
        #expect(rfp(3.2).ceiling().isEqual(to: rfp(4.0)))
        #expect(rfp(-3.2).ceiling().isEqual(to: rfp(-3.0)))
        #expect(rfp(3.0).ceiling().isEqual(to: rfp(3.0)))
        #expect(rfr(7, 2).ceiling().isEqual(to: rei(4)))
        #expect(rfr(-7, 2).ceiling().isEqual(to: rei(-3)))
    }

    @Test
    func compare_to() {
        #expect(rei(3).isLess(than: rei(5)))
        #expect(!rei(5).isLess(than: rei(3)))
        #expect(!rei(3).isLess(than: rei(3)))
        #expect(rfp(1.5).isLess(than: rfp(2.5)))
        #expect(!rfp(2.5).isLess(than: rfp(1.5)))
        #expect(rfr(1, 4).isLess(than: rfr(1, 2)))
        #expect(!rfr(1, 2).isLess(than: rfr(1, 4)))
        #expect(rei(1).isLess(than: rfp(1.5)))
        #expect(rei(1).isLess(than: rfr(3, 2)))
    }

    @Test
    func cosine() {
        #expect(rei(0).cosine().isEqual(to: rfp(1.0)))
        #expect(rfp(0.0).cosine().isEqual(to: rfp(1.0)))
        #expect(rfr(0, 1).cosine().isEqual(to: rfp(1.0)))
    }

    @Test
    func debugDescription() {
        #expect(rei(42).debugDescription == "small<42>")
        #expect(rfp(3.14).debugDescription == "floatingPoint<3.14>")
        #expect(rfr(3, 4).debugDescription == "fraction<small<3>, small<4>>")
        #expect(Real.nan.debugDescription == "floatingPoint<+nan.0>")
        #expect(Real.positiveInfinity.debugDescription == "floatingPoint<+inf.0>")
        #expect(Real.negativeInfinity.debugDescription == "floatingPoint<-inf.0>")
        #expect(Real.inexactZero.debugDescription == "floatingPoint<0.0>")
    }

    @Test
    func denominator() {
        #expect(rei(42).denominator.isEqual(to: .exactOne))
        #expect(rfp(5.0).denominator.isEqual(to: .inexactOne))
        #expect(rfr(3, 4).denominator.isEqual(to: rei(4)))
        #expect(rfr(7, 2).denominator.isEqual(to: rei(2)))
    }

    @Test
    func description() {
        #expect(rei(42).description == "42")
        #expect(rei(-7).description == "-7")
        #expect(rfp(3.14).description == "3.14")
        #expect(rfr(3, 4).description == "3/4")
        #expect(Real.nan.description == "+nan.0")
        #expect(Real.positiveInfinity.description == "+inf.0")
        #expect(Real.negativeInfinity.description == "-inf.0")
        #expect(Real.inexactZero.description == "0.0")
    }

    @Test
    func divided_by() {
        #expect(rei(10).divided(by: rei(2)).isEqual(to: rei(5)))
        #expect(rei(10).divided(by: rei(3)).isEqual(to: rfr(10, 3)))
        #expect(rfp(10.0).divided(by: rfp(2.0)).isEqual(to: rfp(5.0)))
        #expect(rfr(3, 4).divided(by: rfr(1, 2)).isEqual(to: rfr(3, 2)))
    }

    @Test
    func exact() {
        #expect(Real.inexactOne.exact.isEqual(to: .exactOne))
        #expect(Real.pi.exact.isEqual(to: rfr(355, 113)))
        #expect(Real.inexactZero.exact.isEqual(to: .exactZero))
        #expect(rfp(-0.0).exact.isEqual(to: rei(0)))
        #expect(rfp(-1).exact.isEqual(to: rei(-1)))
        #expect(rfp(5_836_472.0).exact.isEqual(to: rei(5_836_472)))
        #expect(rfp(-5_836_472.0).exact.isEqual(to: rei(-5_836_472)))
        #expect(rfp(583.6472).exact.isEqual(to: rfr(239_879, 411)))
        #expect(rfp(-583.6472).exact.isEqual(to: rfr(-239_879, 411)))
        #expect(rfp(0.5836472).exact.isEqual(to: rfr(157, 269)))
        #expect(rfp(-0.5836472).exact.isEqual(to: rfr(-157, 269)))
    }

    @Test
    func exactIntegerValue() {
        #expect(rei(42).exactIntegerValue.intValue == 42)
        #expect(rei(-7).exactIntegerValue.intValue == -7)
        #expect(rfp(7.0).exactIntegerValue.intValue == 7)
        #expect(rfr(8, 4).exactIntegerValue.intValue == 2)
    }

    @Test
    func exponential() {
        #expect(rei(0).exponential().isEqual(to: rfp(1.0)))
        #expect(rfp(0.0).exponential().isEqual(to: rfp(1.0)))
        #expect(rfr(0, 1).exponential().isEqual(to: rfp(1.0)))
    }

    @Test
    func exponentialBase10() {
        #expect(rei(0).exponentialBase10().isEqual(to: rfp(1.0)))
        #expect(rei(2).exponentialBase10().isEqual(to: rfp(100.0)))
        #expect(rfp(0.0).exponentialBase10().isEqual(to: rfp(1.0)))
    }

    @Test
    func exponentialBase2() {
        #expect(rei(0).exponentialBase2().isEqual(to: rfp(1.0)))
        #expect(rei(3).exponentialBase2().isEqual(to: rfp(8.0)))
        #expect(rfp(0.0).exponentialBase2().isEqual(to: rfp(1.0)))
    }

    @Test
    func exponential_base() {
        #expect(rei(0).exponential(base: rei(2)).isEqual(to: rfp(1.0)))
        #expect(rfp(0.0).exponential(base: rfp(10.0)).isEqual(to: rfp(1.0)))
        #expect(rfr(0, 1).exponential(base: rei(5)).isEqual(to: rfp(1.0)))
    }

    @Test
    func floatingPointValue() {
        #expect(rei(42).floatingPointValue.doubleValue == 42.0)
        #expect(rfp(3.14).floatingPointValue.doubleValue == 3.14)
        #expect(rfr(1, 2).floatingPointValue.doubleValue == 0.5)
    }

    @Test
    func floor() {
        #expect(rei(3).floor().isEqual(to: rei(3)))
        #expect(rfp(3.7).floor().isEqual(to: rfp(3.0)))
        #expect(rfp(-3.7).floor().isEqual(to: rfp(-4.0)))
        #expect(rfp(3.0).floor().isEqual(to: rfp(3.0)))
        #expect(rfr(7, 2).floor().isEqual(to: rei(3)))
        #expect(rfr(-7, 2).floor().isEqual(to: rei(-4)))
    }

    @Test
    func greatestCommonDivisor_with() {
        #expect(rei(12).greatestCommonDivisor(with: rei(8)).isEqual(to: rei(4)))
        #expect(rei(7).greatestCommonDivisor(with: rei(5)).isEqual(to: rei(1)))
        #expect(rei(0).greatestCommonDivisor(with: rei(5)).isEqual(to: rei(5)))
        #expect(rfp(12.0).greatestCommonDivisor(with: rfp(8.0)).isEqual(to: rfp(4.0)))
    }

    @Test
    func hyperbolicCosine() {
        #expect(rei(0).hyperbolicCosine().isEqual(to: rfp(1.0)))
        #expect(rfp(0.0).hyperbolicCosine().isEqual(to: rfp(1.0)))
    }

    @Test
    func hyperbolicSine() {
        #expect(rei(0).hyperbolicSine().isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).hyperbolicSine().isEqual(to: rfp(0.0)))
    }

    @Test
    func hyperbolicTangent() {
        #expect(rei(0).hyperbolicTangent().isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).hyperbolicTangent().isEqual(to: rfp(0.0)))
    }

    @Test
    func hypotenuse_with() {
        #expect(rei(3).hypotenuse(with: rei(4)).isEqual(to: rfp(5.0)))
        #expect(rfp(3.0).hypotenuse(with: rfp(4.0)).isEqual(to: rfp(5.0)))
        #expect(rei(0).hypotenuse(with: rei(5)).isEqual(to: rfp(5.0)))
    }

    @Test
    func inexact() {
        #expect(rei(42).inexact.isInexact)
        #expect(rei(42).inexact.isEqual(to: rfp(42.0)))
        #expect(rfp(3.14).inexact.isEqual(to: rfp(3.14)))
        #expect(rfr(1, 2).inexact.isInexact)
        #expect(rfr(1, 2).inexact.isEqual(to: rfp(0.5)))
    }

    @Test
    func init_binaryFloatingPoint() {
        let r1 = Real(3.14)
        #expect(r1.isInexact)
        #expect(r1.isEqual(to: rfp(3.14)))

        let r2 = Real(0.0)
        #expect(r2.isZero)
        #expect(r2.isInexact)

        let r3 = Real(-2.5)
        #expect(r3.isNegative)
        #expect(r3.isInexact)
    }

    @Test
    func init_binaryInteger() {
        let r1 = Real(42)
        #expect(r1.isExact)
        #expect(r1.isEqual(to: rei(42)))

        let r2 = Real(0)
        #expect(r2.isZero)
        #expect(r2.isExact)

        let r3 = Real(-7)
        #expect(r3.isNegative)
        #expect(r3.isExact)
    }

    @Test
    func inverseCosine() {
        #expect(rei(1).inverseCosine().isEqual(to: rfp(0.0)))
        #expect(rfp(1.0).inverseCosine().isEqual(to: rfp(0.0)))
    }

    @Test
    func inverseHyperbolicCosine() {
        #expect(rei(1).inverseHyperbolicCosine().isEqual(to: rfp(0.0)))
        #expect(rfp(1.0).inverseHyperbolicCosine().isEqual(to: rfp(0.0)))
    }

    @Test
    func inverseHyperbolicSine() {
        #expect(rei(0).inverseHyperbolicSine().isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).inverseHyperbolicSine().isEqual(to: rfp(0.0)))
    }

    @Test
    func inverseHyperbolicTangent() {
        #expect(rei(0).inverseHyperbolicTangent().isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).inverseHyperbolicTangent().isEqual(to: rfp(0.0)))
    }

    @Test
    func inverseSine() {
        #expect(rei(0).inverseSine().isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).inverseSine().isEqual(to: rfp(0.0)))
    }

    @Test
    func inverseTangent() {
        #expect(rei(0).inverseTangent().isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).inverseTangent().isEqual(to: rfp(0.0)))
    }

    @Test
    func inverseTangent2() {
        #expect(rei(0).inverseTangent(rei(1)).isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).inverseTangent(rfp(1.0)).isEqual(to: rfp(0.0)))
    }

    @Test
    func isEqual_to() {
        #expect(rei(42).isEqual(to: rei(42)))
        #expect(!rei(42).isEqual(to: rei(43)))
        #expect(rfp(3.14).isEqual(to: rfp(3.14)))
        #expect(!rfp(3.14).isEqual(to: rfp(2.71)))
        #expect(rfr(1, 2).isEqual(to: rfr(1, 2)))
        #expect(!rfr(1, 2).isEqual(to: rfr(1, 3)))
        #expect(rei(2).isEqual(to: rfp(2.0)))
        #expect(rei(2).isEqual(to: rfr(4, 2)))
    }

    @Test
    func isEven() {
        #expect(rei(4).isEven)
        #expect(!rei(3).isEven)
        #expect(rei(0).isEven)
        #expect(rfp(4.0).isEven)
        #expect(!rfp(3.0).isEven)
        #expect(rfr(4, 1).isEven)
        #expect(!rfr(3, 1).isEven)
    }

    @Test
    func isExact() {
        #expect(rei(42).isExact)
        #expect(!rfp(3.14).isExact)
        #expect(rfr(3, 4).isExact)
    }

    @Test
    func isFinite() {
        #expect(rei(42).isFinite)
        #expect(rfp(3.14).isFinite)
        #expect(rfr(3, 4).isFinite)
        #expect(!Real.positiveInfinity.isFinite)
        #expect(!Real.negativeInfinity.isFinite)
        #expect(!Real.nan.isFinite)
    }

    @Test
    func isInexact() {
        #expect(!rei(42).isInexact)
        #expect(rfp(3.14).isInexact)
        #expect(!rfr(3, 4).isInexact)
    }

    @Test
    func isInfinite() {
        #expect(!rei(42).isInfinite)
        #expect(!rfp(3.14).isInfinite)
        #expect(!rfr(3, 4).isInfinite)
        #expect(Real.positiveInfinity.isInfinite)
        #expect(Real.negativeInfinity.isInfinite)
    }

    @Test
    func isInteger() {
        #expect(rei(42).isInteger)
        #expect(rfp(3.0).isInteger)
        #expect(!rfp(3.14).isInteger)
        #expect(rfr(6, 3).isInteger)
        #expect(!rfr(3, 4).isInteger)
    }

    @Test
    func isNaN() {
        #expect(Real.nan.isNaN)
        #expect(!rei(0).isNaN)
        #expect(!rfp(1.0).isNaN)
        #expect(!rfr(1, 2).isNaN)
    }

    @Test
    func isNegative() {
        #expect(rei(-3).isNegative)
        #expect(!rei(3).isNegative)
        #expect(!rei(0).isNegative)
        #expect(rfp(-1.5).isNegative)
        #expect(!rfp(1.5).isNegative)
        #expect(rfr(-3, 4).isNegative)
        #expect(!rfr(3, 4).isNegative)
    }

    @Test
    func isOdd() {
        #expect(rei(3).isOdd)
        #expect(!rei(4).isOdd)
        #expect(rfp(3.0).isOdd)
        #expect(!rfp(4.0).isOdd)
        #expect(rfr(3, 1).isOdd)
        #expect(!rfr(4, 1).isOdd)
    }

    @Test
    func isPositive() {
        #expect(rei(3).isPositive)
        #expect(!rei(-3).isPositive)
        #expect(!rei(0).isPositive)
        #expect(rfp(1.5).isPositive)
        #expect(!rfp(-1.5).isPositive)
        #expect(rfr(3, 4).isPositive)
        #expect(!rfr(-3, 4).isPositive)
    }

    @Test
    func isRational() {
        #expect(rei(42).isRational)
        #expect(rfp(3.14).isRational)
        #expect(rfr(3, 4).isRational)
        #expect(!Real.nan.isRational)
        #expect(!Real.positiveInfinity.isRational)
        #expect(!Real.negativeInfinity.isRational)
    }

    @Test
    func isZero() {
        #expect(rei(0).isZero)
        #expect(!rei(42).isZero)
        #expect(Real.inexactZero.isZero)
        #expect(!rfp(1.0).isZero)
        #expect(rfr(0, 1).isZero)
        #expect(!rfr(3, 4).isZero)
    }

    @Test
    func leastCommonMultiple_with() {
        #expect(rei(4).leastCommonMultiple(with: rei(6)).isEqual(to: rei(12)))
        #expect(rei(3).leastCommonMultiple(with: rei(5)).isEqual(to: rei(15)))
        #expect(rfp(4.0).leastCommonMultiple(with: rfp(6.0)).isEqual(to: rfp(12.0)))
    }

    @Test
    func logarithm() {
        #expect(rei(1).logarithm().isEqual(to: rfp(0.0)))
        #expect(rfp(1.0).logarithm().isEqual(to: rfp(0.0)))
    }

    @Test
    func logarithmBase10() {
        #expect(rei(1).logarithmBase10().isEqual(to: rfp(0.0)))
        #expect(rei(100).logarithmBase10().isEqual(to: rfp(2.0)))
        #expect(rfp(1.0).logarithmBase10().isEqual(to: rfp(0.0)))
    }

    @Test
    func logarithmBase2() {
        #expect(rei(1).logarithmBase2().isEqual(to: rfp(0.0)))
        #expect(rei(8).logarithmBase2().isEqual(to: rfp(3.0)))
        #expect(rfp(1.0).logarithmBase2().isEqual(to: rfp(0.0)))
    }

    @Test
    func logarithm_base() {
        #expect(rei(1).logarithm(base: rei(10)).isEqual(to: rfp(0.0)))
        #expect(rfp(1.0).logarithm(base: rfp(10.0)).isEqual(to: rfp(0.0)))
    }

    @Test
    func modulo() {
        #expect(rei(7).modulo(rei(3)).isEqual(to: rei(1)))
        #expect(rei(-7).modulo(rei(3)).isEqual(to: rei(2)))
        #expect(rei(0).modulo(rei(3)).isEqual(to: rei(0)))
        #expect(rfp(7.0).modulo(rfp(3.0)).isEqual(to: rfp(1.0)))
    }

    @Test
    func multiplied_by() {
        #expect(rei(3).multiplied(by: rei(4)).isEqual(to: rei(12)))
        #expect(rfp(2.5).multiplied(by: rfp(4.0)).isEqual(to: rfp(10.0)))
        #expect(rfr(2, 3).multiplied(by: rfr(3, 4)).isEqual(to: rfr(1, 2)))
        #expect(rei(3).multiplied(by: rfp(2.0)).isEqual(to: rfp(6.0)))
    }

    @Test
    func negated() {
        #expect(rei(5).negated().isEqual(to: rei(-5)))
        #expect(rei(-5).negated().isEqual(to: rei(5)))
        #expect(rei(0).negated().isEqual(to: rei(0)))
        #expect(rfp(3.14).negated().isEqual(to: rfp(-3.14)))
        #expect(rfr(3, 4).negated().isEqual(to: rfr(-3, 4)))
    }

    @Test
    func numerator() {
        #expect(rei(42).numerator.isEqual(to: rei(42)))
        #expect(rfp(7.0).numerator.isEqual(to: rfp(7.0)))
        #expect(rfr(3, 4).numerator.isEqual(to: rei(3)))
        #expect(rfr(-5, 7).numerator.isEqual(to: rei(-5)))
    }

    @Test
    func parse_radix_exactness() {
        #expect(Real.parse(input: "42", radix: .decimal, exactness: .unspecified)?.isEqual(to: rei(42)) == true)
        #expect(Real.parse(input: "42", radix: .decimal, exactness: .exact)?.isEqual(to: rei(42)) == true)
        #expect(Real.parse(input: "42", radix: .decimal, exactness: .inexact)?.isEqual(to: rfp(42.0)) == true)
        #expect(Real.parse(input: "3/4", radix: .decimal, exactness: .unspecified)?.isEqual(to: rfr(3, 4)) == true)
        #expect(Real.parse(input: "3/4", radix: .decimal, exactness: .inexact)?.isEqual(to: rfp(0.75)) == true)
        #expect(Real.parse(input: "3.14", radix: .decimal, exactness: .unspecified)?.isEqual(to: rfp(3.14)) == true)
        #expect(Real.parse(input: "3.14", radix: .decimal, exactness: .exact) == nil)
        #expect(Real.parse(input: "+inf.0", radix: .decimal, exactness: .unspecified)?.isInfinite == true)
        #expect(Real.parse(input: "+nan.0", radix: .decimal, exactness: .unspecified)?.isNaN == true)
        #expect(Real.parse(input: "101", radix: .binary, exactness: .unspecified)?.isEqual(to: rei(5)) == true)
        #expect(Real.parse(input: "ff", radix: .hexadecimal, exactness: .unspecified)?.isEqual(to: rei(255)) == true)
        #expect(Real.parse(input: "17", radix: .octal, exactness: .unspecified)?.isEqual(to: rei(15)) == true)
        #expect(Real.parse(input: "xyz", radix: .decimal, exactness: .unspecified) == nil)
    }

    @Test
    func power() {
        #expect(rei(0).exponential(base: rei(2)).isEqual(to: rfp(1.0)))
        #expect(rfp(0.0).exponential(base: rfp(5.0)).isEqual(to: rfp(1.0)))
        #expect(rfr(0, 1).exponential(base: rei(7)).isEqual(to: rfp(1.0)))
    }

    @Test
    func quotient_dividingBy() {
        #expect(rei(10).quotient(dividingBy: rei(3)).isEqual(to: rei(3)))
        #expect(rei(-10).quotient(dividingBy: rei(3)).isEqual(to: rei(-3)))
        #expect(rfp(10.0).quotient(dividingBy: rfp(3.0)).isEqual(to: rfp(3.0)))
    }

    @Test
    func rationalize() {
        #expect(Real.pi.exact.rationalize(within: rfr(1, 10)).require().isEqual(to: rfr(16, 5)))
        #expect(Real.pi.exact.rationalize(within: rfr(1, 100)).require().isEqual(to: rfr(22, 7)))
        #expect(Real.pi.exact.rationalize(within: rfr(1, 1_000)).require().isEqual(to: rfr(201, 64)))
        #expect(Real.pi.exact.rationalize(within: rfr(1, 10_000)).require().isEqual(to: rfr(333, 106)))
        #expect(Real.pi.exact.rationalize(within: rfr(1, 100_000)).require().isEqual(to: rfr(355, 113)))
        #expect(Real.pi.exact.rationalize(within: rfr(1, 1_000_000)).require().isEqual(to: rfr(355, 113)))

        #expect(Real.pi.negated().exact.rationalize(within: rfr(1, 10)).require().isEqual(to: rfr(-16, 5)))
        #expect(Real.pi.negated().exact.rationalize(within: rfr(1, 100)).require().isEqual(to: rfr(-22, 7)))
        #expect(Real.pi.negated().exact.rationalize(within: rfr(1, 1_000)).require().isEqual(to: rfr(-201, 64)))
        #expect(Real.pi.negated().exact.rationalize(within: rfr(1, 10_000)).require().isEqual(to: rfr(-333, 106)))
        #expect(Real.pi.negated().exact.rationalize(within: rfr(1, 100_000)).require().isEqual(to: rfr(-355, 113)))
        #expect(Real.pi.negated().exact.rationalize(within: rfr(1, 1_000_000)).require().isEqual(to: rfr(-355, 113)))

        #expect(rfp(0.5836472).exact.rationalize(within: rfr(1, 10)).require().isEqual(to: rfr(1, 2)))
        #expect(rfp(0.5836472).exact.rationalize(within: rfr(1, 100)).require().isEqual(to: rfr(7, 12)))
        #expect(rfp(0.5836472).exact.rationalize(within: rfr(1, 1_000)).require().isEqual(to: rfr(7, 12)))
        #expect(rfp(0.5836472).exact.rationalize(within: rfr(1, 10_000)).require().isEqual(to: rfr(122, 209)))
        #expect(rfp(0.5836472).exact.rationalize(within: rfr(1, 100_000)).require().isEqual(to: rfr(157, 269)))
        #expect(rfp(0.5836472).exact.rationalize(within: rfr(1, 1_000_000)).require().isEqual(to: rfr(157, 269)))

        #expect(rfp(-0.5836472).exact.rationalize(within: rfr(1, 10)).require().isEqual(to: rfr(-1, 2)))
        #expect(rfp(-0.5836472).exact.rationalize(within: rfr(1, 100)).require().isEqual(to: rfr(-7, 12)))
        #expect(rfp(-0.5836472).exact.rationalize(within: rfr(1, 1_000)).require().isEqual(to: rfr(-7, 12)))
        #expect(rfp(-0.5836472).exact.rationalize(within: rfr(1, 10_000)).require().isEqual(to: rfr(-122, 209)))
        #expect(rfp(-0.5836472).exact.rationalize(within: rfr(1, 100_000)).require().isEqual(to: rfr(-157, 269)))
        #expect(rfp(-0.5836472).exact.rationalize(within: rfr(1, 1_000_000)).require().isEqual(to: rfr(-157, 269)))
    }

    @Test
    func remainder_dividingBy() {
        #expect(rei(10).remainder(dividingBy: rei(3)).isEqual(to: rei(1)))
        #expect(rei(-10).remainder(dividingBy: rei(3)).isEqual(to: rei(-1)))
        #expect(rei(0).remainder(dividingBy: rei(3)).isEqual(to: rei(0)))
        #expect(rfp(10.0).remainder(dividingBy: rfp(3.0)).isEqual(to: rfp(1.0)))
    }

    @Test
    func round() {
        #expect(rei(3).round().isEqual(to: rei(3)))
        #expect(rfp(3.7).round().isEqual(to: rfp(4.0)))
        #expect(rfp(3.2).round().isEqual(to: rfp(3.0)))
        #expect(rfp(-3.7).round().isEqual(to: rfp(-4.0)))
        #expect(rfr(7, 3).round().isEqual(to: rei(2)))
        #expect(rfr(-7, 3).round().isEqual(to: rei(-2)))
    }

    @Test
    func simplified() {
        #expect(rei(42).simplified.isEqual(to: rei(42)))
        #expect(rfp(3.14).simplified.isEqual(to: rfp(3.14)))
        #expect(rfr(6, 3).simplified.isEqual(to: rei(2)))
        #expect(rfr(3, 4).simplified.isEqual(to: rfr(3, 4)))
    }

    @Test
    func sine() {
        #expect(rei(0).sine().isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).sine().isEqual(to: rfp(0.0)))
        #expect(rfr(0, 1).sine().isEqual(to: rfp(0.0)))
    }

    @Test
    func squareRoot() {
        #expect(rei(4).squareRoot().isEqual(to: rfp(2.0)))
        #expect(rfp(9.0).squareRoot().isEqual(to: rfp(3.0)))
        #expect(rei(0).squareRoot().isEqual(to: rfp(0.0)))
    }

    @Test
    func subtracting() {
        #expect(rei(7).subtracting(rei(3)).isEqual(to: rei(4)))
        #expect(rfp(5.5).subtracting(rfp(2.5)).isEqual(to: rfp(3.0)))
        #expect(rfr(3, 4).subtracting(rfr(1, 4)).isEqual(to: rfr(1, 2)))
        #expect(rei(5).subtracting(rfp(2.0)).isEqual(to: rfp(3.0)))
    }

    @Test
    func tangent() {
        #expect(rei(0).tangent().isEqual(to: rfp(0.0)))
        #expect(rfp(0.0).tangent().isEqual(to: rfp(0.0)))
        #expect(rfr(0, 1).tangent().isEqual(to: rfp(0.0)))
    }

    @Test
    func truncate() {
        #expect(rei(3).truncate().isEqual(to: rei(3)))
        #expect(rfp(3.7).truncate().isEqual(to: rfp(3.0)))
        #expect(rfp(-3.7).truncate().isEqual(to: rfp(-3.0)))
        #expect(rfr(7, 2).truncate().isEqual(to: rei(3)))
        #expect(rfr(-7, 2).truncate().isEqual(to: rei(-3)))
    }
}
