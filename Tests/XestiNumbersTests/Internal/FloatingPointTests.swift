// © 2025–2026 John Gary Pusey (see LICENSE.md)

import RealModule
import Testing
@testable import XestiNumbers

struct FloatingPointTests {
}

// MARK: -

extension FloatingPointTests {
    @Test
    func adding() {
        #expect(fp(3.0).adding(fp(4.0)).testEqual(to: fp(7.0)))
        #expect(fp(-1.5).adding(fp(2.5)).testEqual(to: fp(1.0)))
        #expect(FloatingPoint.zero.adding(fp(5.0)).testEqual(to: fp(5.0)))
        #expect(fp(-3.0).adding(fp(-4.0)).testEqual(to: fp(-7.0)))
    }

    @Test
    func ceiling() {
        #expect(fp(3.2).ceiling().testEqual(to: fp(4.0)))
        #expect(fp(-3.7).ceiling().testEqual(to: fp(-3.0)))
        #expect(fp(3.0).ceiling().testEqual(to: fp(3.0)))
        #expect(fp(-0.5).ceiling().isZero)
    }

    @Test
    func compare_to() {
        #expect(fp(1.0).isLess(than: fp(2.0)))
        #expect(!fp(2.0).isLess(than: fp(1.0)))
        #expect(!fp(1.0).isLess(than: fp(1.0)))
        #expect(fp(-1.0).isLess(than: fp(0.0)))
        #expect(FloatingPoint.negativeInfinity.isLess(than: fp(0.0)))
        #expect(!FloatingPoint.nan.isLess(than: fp(0.0)))
    }

    @Test
    func cosine() {
        #expect(FloatingPoint.zero.cosine().testEqual(to: fp(1.0)))
        #expect(FloatingPoint.pi.cosine().testEqual(to: fp(-1.0)))
        #expect(fp(Double.pi / 3).cosine().testEqual(to: fp(Double.cos(Double.pi / 3))))
    }

    @Test
    func debugDescription() {
        #expect(String(reflecting: FloatingPoint.nan) == "floatingPoint<+nan.0>")
        #expect(String(reflecting: FloatingPoint.negativeInfinity) == "floatingPoint<-inf.0>")
        #expect(String(reflecting: FloatingPoint.one) == "floatingPoint<1.0>")
        #expect(String(reflecting: FloatingPoint.pi) == "floatingPoint<3.141592653589793>")
        #expect(String(reflecting: FloatingPoint.positiveInfinity) == "floatingPoint<+inf.0>")
        #expect(String(reflecting: FloatingPoint.zero) == "floatingPoint<0.0>")
        #expect(String(reflecting: fp(-0.0)) == "floatingPoint<0.0>")
        #expect(String(reflecting: fp(-Double.pi)) == "floatingPoint<-3.141592653589793>")
        #expect(String(reflecting: fp(-1)) == "floatingPoint<-1.0>")
    }

    @Test
    func description() {
        #expect(String(describing: FloatingPoint.nan) == "+nan.0")
        #expect(String(describing: FloatingPoint.negativeInfinity) == "-inf.0")
        #expect(String(describing: FloatingPoint.one) == "1.0")
        #expect(String(describing: FloatingPoint.pi) == "3.141592653589793")
        #expect(String(describing: FloatingPoint.positiveInfinity) == "+inf.0")
        #expect(String(describing: FloatingPoint.zero) == "0.0")
        #expect(String(describing: fp(-0.0)) == "0.0")
        #expect(String(describing: fp(-Double.pi)) == "-3.141592653589793")
        #expect(String(describing: fp(-1)) == "-1.0")
    }

    @Test
    func divided_by() {
        #expect(fp(10.0).divided(by: fp(2.0)).testEqual(to: fp(5.0)))
        #expect(fp(-6.0).divided(by: fp(3.0)).testEqual(to: fp(-2.0)))
        #expect(fp(1.0).divided(by: fp(0.0)).isInfinite)
        #expect(fp(0.0).divided(by: fp(0.0)).isNaN)
    }

    @Test
    func doubleValue() {
        #expect(FloatingPoint.one.doubleValue == 1.0)
        #expect(FloatingPoint.zero.doubleValue == 0.0)
        #expect(FloatingPoint.pi.doubleValue == Double.pi)
        #expect(fp(-2.5).doubleValue == -2.5)
        #expect(FloatingPoint.nan.doubleValue.isNaN)
    }

    @Test
    func exactIntegerValue() {
        #expect(fp(-0.0).exactIntegerValue.isEqual(to: ei(0)))
        #expect(fp(-1).exactIntegerValue.isEqual(to: ei(-1)))
        #expect(FloatingPoint.one.exactIntegerValue.isEqual(to: ei(1)))
        #expect(FloatingPoint.zero.exactIntegerValue.isEqual(to: ei(0)))
    }

    @Test
    func exponential() {
        #expect(FloatingPoint.zero.exponential().testEqual(to: fp(1.0)))
        #expect(FloatingPoint.one.exponential().testEqual(to: fp(Double.exp(1.0))))
        #expect(fp(2.0).exponential().testEqual(to: fp(Double.exp(2.0))))
    }

    @Test
    func exponential_base() {
        #expect(fp(3.0).exponential(base: fp(2.0)).testEqual(to: fp(8.0)))
        #expect(fp(0.0).exponential(base: fp(5.0)).testEqual(to: fp(1.0)))
        #expect(fp(2.0).exponential(base: fp(10.0)).testEqual(to: fp(100.0)))
    }

    @Test
    func exponentialBase10() {
        #expect(fp(2.0).exponentialBase10().testEqual(to: fp(100.0)))
        #expect(fp(0.0).exponentialBase10().testEqual(to: fp(1.0)))
        #expect(fp(3.0).exponentialBase10().testEqual(to: fp(1_000.0)))
    }

    @Test
    func exponentialBase2() {
        #expect(fp(3.0).exponentialBase2().testEqual(to: fp(8.0)))
        #expect(fp(0.0).exponentialBase2().testEqual(to: fp(1.0)))
        #expect(fp(10.0).exponentialBase2().testEqual(to: fp(1_024.0)))
    }

    @Test
    func floatValue() {
        #expect(FloatingPoint.one.floatValue == 1.0)
        #expect(FloatingPoint.zero.floatValue == 0.0)
        #expect(fp(-2.5).floatValue == -2.5)
        #expect(FloatingPoint.nan.floatValue.isNaN)
    }

    @Test
    func floor() {
        #expect(fp(3.7).floor().testEqual(to: fp(3.0)))
        #expect(fp(-3.2).floor().testEqual(to: fp(-4.0)))
        #expect(fp(3.0).floor().testEqual(to: fp(3.0)))
    }

    @Test
    func fractionValue() {
        #expect(fp(-1.75).fractionValue.isEqual(to: fr(-7, 4)))
        #expect(fp(1.03125).fractionValue.isEqual(to: fr(33, 32)))
        #expect(fp(5.0 / 17.0).fractionValue.isEqual(to: fr(5, 17)))
        #expect(FloatingPoint.pi.fractionValue.isEqual(to: fr(355, 113)))
        #expect(FloatingPoint.zero.fractionValue.isEqual(to: fr(0, 1)))
    }

    @Test
    func hyperbolicCosine() {
        #expect(FloatingPoint.zero.hyperbolicCosine().testEqual(to: fp(1.0)))
        #expect(fp(1.0).hyperbolicCosine().testEqual(to: fp(Double.cosh(1.0))))
        #expect(fp(-1.0).hyperbolicCosine().testEqual(to: fp(Double.cosh(-1.0))))
    }

    @Test
    func hyperbolicSine() {
        #expect(FloatingPoint.zero.hyperbolicSine().testEqual(to: fp(0.0)))
        #expect(fp(1.0).hyperbolicSine().testEqual(to: fp(Double.sinh(1.0))))
        #expect(fp(-1.0).hyperbolicSine().testEqual(to: fp(Double.sinh(-1.0))))
    }

    @Test
    func hyperbolicTangent() {
        #expect(FloatingPoint.zero.hyperbolicTangent().testEqual(to: fp(0.0)))
        #expect(fp(1.0).hyperbolicTangent().testEqual(to: fp(Double.tanh(1.0))))
        #expect(fp(-1.0).hyperbolicTangent().testEqual(to: fp(Double.tanh(-1.0))))
    }

    @Test
    func hypotenuse_with() {
        #expect(fp(3.0).hypotenuse(with: fp(4.0)).testEqual(to: fp(5.0)))
        #expect(fp(0.0).hypotenuse(with: fp(5.0)).testEqual(to: fp(5.0)))
        #expect(fp(1.0).hypotenuse(with: fp(1.0)).testEqual(to: fp(Double.sqrt(2.0))))
    }

    @Test
    func init_binaryFloatingPoint() {
        #expect(fp(3.14).testEqual(to: fp(3.14)))
        #expect(fp(-2.5).testEqual(to: fp(-2.5)))
        #expect(fp(0.0).isZero)
        #expect(fp(-0.0).isZero)
        #expect(fp(Double.infinity).isInfinite)
        #expect(fp(Double.nan).isNaN)
    }

    @Test
    func init_binaryInteger() {
        #expect(FloatingPoint(Int(42)).testEqual(to: fp(42.0)))
        #expect(FloatingPoint(Int(-7)).testEqual(to: fp(-7.0)))
        #expect(FloatingPoint(Int(0)).isZero)
    }

    @Test
    func inverseCosine() {
        #expect(fp(-0.5).inverseCosine().testEqual(to: fp(Double.acos(-0.5))))
        #expect(fp(-0.7071).inverseCosine().testEqual(to: fp(Double.acos(-0.7071))))
        #expect(fp(-0.99).inverseCosine().testEqual(to: fp(Double.acos(-0.99))))
        #expect(fp(-1).inverseCosine().testEqual(to: fp(Double.acos(-1))))
        #expect(fp(0.5).inverseCosine().testEqual(to: fp(Double.acos(0.5))))
        #expect(fp(0.7071).inverseCosine().testEqual(to: fp(Double.acos(0.7071))))
        #expect(fp(0.99).inverseCosine().testEqual(to: fp(Double.acos(0.99))))
        #expect(fp(0).inverseCosine().testEqual(to: fp(Double.acos(0))))
        #expect(fp(1).inverseCosine().testEqual(to: fp(Double.acos(1))))
        #expect(fp(2).inverseCosine().isNaN)
    }

    @Test
    func inverseHyperbolicCosine() {
        #expect(fp(1.0).inverseHyperbolicCosine().testEqual(to: fp(0.0)))
        #expect(fp(2.0).inverseHyperbolicCosine().testEqual(to: fp(Double.acosh(2.0))))
        #expect(fp(10.0).inverseHyperbolicCosine().testEqual(to: fp(Double.acosh(10.0))))
        #expect(fp(0.5).inverseHyperbolicCosine().isNaN)
    }

    @Test
    func inverseHyperbolicSine() {
        #expect(FloatingPoint.zero.inverseHyperbolicSine().testEqual(to: fp(0.0)))
        #expect(fp(1.0).inverseHyperbolicSine().testEqual(to: fp(Double.asinh(1.0))))
        #expect(fp(-1.0).inverseHyperbolicSine().testEqual(to: fp(Double.asinh(-1.0))))
    }

    @Test
    func inverseHyperbolicTangent() {
        #expect(FloatingPoint.zero.inverseHyperbolicTangent().testEqual(to: fp(0.0)))
        #expect(fp(0.5).inverseHyperbolicTangent().testEqual(to: fp(Double.atanh(0.5))))
        #expect(fp(-0.5).inverseHyperbolicTangent().testEqual(to: fp(Double.atanh(-0.5))))
    }

    @Test
    func inverseSine() {
        #expect(fp(-0.5).inverseSine().testEqual(to: fp(Double.asin(-0.5))))
        #expect(fp(-0.7071).inverseSine().testEqual(to: fp(Double.asin(-0.7071))))
        #expect(fp(-0.99).inverseSine().testEqual(to: fp(Double.asin(-0.99))))
        #expect(fp(-1).inverseSine().testEqual(to: fp(Double.asin(-1))))
        #expect(fp(0.5).inverseSine().testEqual(to: fp(Double.asin(0.5))))
        #expect(fp(0.7071).inverseSine().testEqual(to: fp(Double.asin(0.7071))))
        #expect(fp(0.99).inverseSine().testEqual(to: fp(Double.asin(0.99))))
        #expect(fp(0).inverseSine().testEqual(to: fp(Double.asin(0))))
        #expect(fp(1).inverseSine().testEqual(to: fp(Double.asin(1))))
        #expect(fp(2).inverseSine().isNaN)
    }

    @Test
    func inverseTangent() {
        #expect(fp(-0.5).inverseTangent().testEqual(to: fp(Double.atan(-0.5))))
        #expect(fp(-1).inverseTangent().testEqual(to: fp(Double.atan(-1))))
        #expect(fp(-10).inverseTangent().testEqual(to: fp(Double.atan(-10))))
        #expect(fp(-2).inverseTangent().testEqual(to: fp(Double.atan(-2))))
        #expect(fp(0.5).inverseTangent().testEqual(to: fp(Double.atan(0.5))))
        #expect(fp(0).inverseTangent().testEqual(to: fp(Double.atan(0))))
        #expect(fp(1).inverseTangent().testEqual(to: fp(Double.atan(1))))
        #expect(fp(10).inverseTangent().testEqual(to: fp(Double.atan(10))))
        #expect(fp(100).inverseTangent().testEqual(to: fp(Double.atan(100))))
        #expect(fp(2).inverseTangent().testEqual(to: fp(Double.atan(2))))
    }

    @Test
    func inverseTangent2() {
        #expect(fp(1.0).inverseTangent(fp(1.0)).testEqual(to: fp(Double.atan2(y: 1.0, x: 1.0))))
        #expect(fp(0.0).inverseTangent(fp(1.0)).testEqual(to: fp(0.0)))
        #expect(fp(1.0).inverseTangent(fp(0.0)).testEqual(to: fp(Double.pi / 2)))
        let atan2val = Double.atan2(y: -1.0, x: -1.0)
        #expect(fp(-1.0).inverseTangent(fp(-1.0)).testEqual(to: fp(atan2val)))
    }

    @Test
    func isEqual_to() {
        #expect(FloatingPoint.one.isEqual(to: fp(1.0)))
        #expect(!FloatingPoint.one.isEqual(to: fp(2.0)))
        #expect(FloatingPoint.zero.isEqual(to: fp(0.0)))
        #expect(!FloatingPoint.nan.isEqual(to: FloatingPoint.nan))
    }

    @Test
    func isFinite() {
        #expect(!FloatingPoint.nan.isFinite)
        #expect(!FloatingPoint.negativeInfinity.isFinite)
        #expect(FloatingPoint.one.isFinite)
        #expect(FloatingPoint.pi.isFinite)
        #expect(!FloatingPoint.positiveInfinity.isFinite)
        #expect(FloatingPoint.zero.isFinite)
    }

    @Test
    func isInfinite() {
        #expect(!FloatingPoint.nan.isInfinite)
        #expect(FloatingPoint.negativeInfinity.isInfinite)
        #expect(!FloatingPoint.one.isInfinite)
        #expect(!FloatingPoint.pi.isInfinite)
        #expect(FloatingPoint.positiveInfinity.isInfinite)
        #expect(!FloatingPoint.zero.isInfinite)
    }

    @Test
    func isInteger() {
        #expect(!FloatingPoint.nan.isInteger)
        #expect(!FloatingPoint.negativeInfinity.isInteger)
        #expect(FloatingPoint.one.isInteger)
        #expect(!FloatingPoint.pi.isInteger)
        #expect(!FloatingPoint.positiveInfinity.isInteger)
        #expect(FloatingPoint.zero.isInteger)
    }

    @Test
    func isNaN() {
        #expect(FloatingPoint.nan.isNaN)
        #expect(!FloatingPoint.negativeInfinity.isNaN)
        #expect(!FloatingPoint.one.isNaN)
        #expect(!FloatingPoint.pi.isNaN)
        #expect(!FloatingPoint.positiveInfinity.isNaN)
        #expect(!FloatingPoint.zero.isNaN)
    }

    @Test
    func isNegative() {
        #expect(!FloatingPoint.nan.isNegative)
        #expect(FloatingPoint.negativeInfinity.isNegative)
        #expect(!FloatingPoint.one.isNegative)
        #expect(!FloatingPoint.pi.isNegative)
        #expect(!FloatingPoint.positiveInfinity.isNegative)
        #expect(!FloatingPoint.zero.isNegative)
        #expect(!fp(-0.0).isNegative)
        #expect(fp(-Double.pi).isNegative)
        #expect(fp(-1).isNegative)
    }

    @Test
    func isPositive() {
        #expect(!FloatingPoint.nan.isPositive)
        #expect(!FloatingPoint.negativeInfinity.isPositive)
        #expect(FloatingPoint.one.isPositive)
        #expect(FloatingPoint.pi.isPositive)
        #expect(FloatingPoint.positiveInfinity.isPositive)
        #expect(!FloatingPoint.zero.isPositive)
        #expect(!fp(-0.0).isPositive)
        #expect(!fp(-Double.pi).isPositive)
        #expect(!fp(-1).isPositive)
    }

    @Test
    func isZero() {
        #expect(!FloatingPoint.nan.isZero)
        #expect(!FloatingPoint.negativeInfinity.isZero)
        #expect(!FloatingPoint.one.isZero)
        #expect(!FloatingPoint.pi.isZero)
        #expect(!FloatingPoint.positiveInfinity.isZero)
        #expect(FloatingPoint.zero.isZero)
        #expect(fp(-0.0).isZero)
        #expect(!fp(-Double.pi).isZero)
        #expect(!fp(-1).isZero)
    }

    @Test
    func logarithm() {
        #expect(FloatingPoint.one.logarithm().testEqual(to: fp(0.0)))
        #expect(fp(Double.exp(1.0)).logarithm().testEqual(to: fp(1.0)))
        #expect(fp(Double.exp(2.0)).logarithm().testEqual(to: fp(2.0)))
        #expect(fp(-1.0).logarithm().isNaN)
    }

    @Test
    func logarithm_base() {
        #expect(fp(8.0).logarithm(base: fp(2.0)).testEqual(to: fp(3.0)))
        #expect(fp(100.0).logarithm(base: fp(10.0)).testEqual(to: fp(2.0)))
        #expect(fp(1.0).logarithm(base: fp(5.0)).testEqual(to: fp(0.0)))
    }

    @Test
    func logarithmBase10() {
        #expect(fp(100.0).logarithmBase10().testEqual(to: fp(2.0)))
        #expect(fp(1.0).logarithmBase10().testEqual(to: fp(0.0)))
        #expect(fp(1_000.0).logarithmBase10().testEqual(to: fp(3.0)))
    }

    @Test
    func logarithmBase2() {
        #expect(fp(8.0).logarithmBase2().testEqual(to: fp(3.0)))
        #expect(fp(1.0).logarithmBase2().testEqual(to: fp(0.0)))
        #expect(fp(1_024.0).logarithmBase2().testEqual(to: fp(10.0)))
    }

    @Test
    func multiplied_by() {
        #expect(fp(3.0).multiplied(by: fp(4.0)).testEqual(to: fp(12.0)))
        #expect(fp(-2.0).multiplied(by: fp(3.0)).testEqual(to: fp(-6.0)))
        #expect(FloatingPoint.zero.multiplied(by: fp(42.0)).isZero)
    }

    @Test
    func negated() {
        #expect(FloatingPoint.one.negated().testEqual(to: fp(-1.0)))
        #expect(fp(-3.5).negated().testEqual(to: fp(3.5)))
        #expect(FloatingPoint.zero.negated().isZero)
    }

    @Test
    func parse() {
        #expect(FloatingPoint.parse(input: "3.14")?.testEqual(to: fp(3.14)) == true)
        #expect(FloatingPoint.parse(input: "-2.5")?.testEqual(to: fp(-2.5)) == true)
        #expect(FloatingPoint.parse(input: "0.0")?.isZero == true)
        #expect(FloatingPoint.parse(input: "1.0")?.testEqual(to: fp(1.0)) == true)
        #expect(FloatingPoint.parse(input: "+inf.0")?.isInfinite == true)
        #expect(FloatingPoint.parse(input: "-inf.0")?.isInfinite == true)
        #expect(FloatingPoint.parse(input: "+nan.0")?.isNaN == true)
        #expect(FloatingPoint.parse(input: "-nan.0")?.isNaN == true)
        #expect(FloatingPoint.parse(input: "abc") == nil)
    }

    @Test
    func power() {
        #expect(fp(2.0).exponential(base: fp(3.0)).testEqual(to: fp(9.0)))
        #expect(fp(0.5).exponential(base: fp(4.0)).testEqual(to: fp(2.0)))
        #expect(fp(-1.0).exponential(base: fp(2.0)).testEqual(to: fp(0.5)))
        #expect(fp(0.0).exponential(base: fp(7.0)).testEqual(to: fp(1.0)))
    }

    @Test
    func round() {
        #expect(fp(3.3).round().testEqual(to: fp(3.0)))
        #expect(fp(3.7).round().testEqual(to: fp(4.0)))
        #expect(fp(-3.5).round().testEqual(to: fp(-4.0)))
        #expect(fp(3.5).round().testEqual(to: fp(4.0)))
    }

    @Test
    func sine() {
        #expect(FloatingPoint.zero.sine().testEqual(to: fp(0.0)))
        #expect(fp(Double.pi / 2).sine().testEqual(to: fp(1.0)))
        #expect(fp(Double.pi / 6).sine().testEqual(to: fp(Double.sin(Double.pi / 6))))
    }

    @Test
    func squareRoot() {
        #expect(fp(4.0).squareRoot().testEqual(to: fp(2.0)))
        #expect(fp(9.0).squareRoot().testEqual(to: fp(3.0)))
        #expect(FloatingPoint.zero.squareRoot().isZero)
        #expect(fp(-1.0).squareRoot().isNaN)
    }

    @Test
    func subtracting() {
        #expect(fp(7.0).subtracting(fp(3.0)).testEqual(to: fp(4.0)))
        #expect(fp(3.0).subtracting(fp(7.0)).testEqual(to: fp(-4.0)))
        #expect(FloatingPoint.zero.subtracting(FloatingPoint.zero).isZero)
    }

    @Test
    func tangent() {
        #expect(FloatingPoint.zero.tangent().testEqual(to: fp(0.0)))
        #expect(fp(Double.pi / 4).tangent().testEqual(to: fp(Double.tan(Double.pi / 4))))
        #expect(fp(-Double.pi / 4).tangent().testEqual(to: fp(Double.tan(-Double.pi / 4))))
    }

    @Test
    func truncate() {
        #expect(fp(3.7).truncate().testEqual(to: fp(3.0)))
        #expect(fp(-3.7).truncate().testEqual(to: fp(-3.0)))
        #expect(fp(3.0).truncate().testEqual(to: fp(3.0)))
    }
}
