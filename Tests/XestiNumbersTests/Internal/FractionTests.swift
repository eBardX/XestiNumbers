// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct FractionTests {
}

// MARK: -

extension FractionTests {
    @Test
    func adding() {
        #expect(fr(1, 2).adding(fr(1, 6)).isEqual(to: fr(2, 3)))
    }

    @Test
    func ceiling() {
        #expect(fr(-50, 10).ceiling().isEqual(to: ei(-5)))
        #expect(fr(-43, 10).ceiling().isEqual(to: ei(-4)))
        #expect(fr(-35, 10).ceiling().isEqual(to: ei(-3)))
        #expect(fr(-5, 10).ceiling().isEqual(to: ei(0)))
        #expect(fr(0, 10).ceiling().isEqual(to: ei(0)))
        #expect(fr(5, 10).ceiling().isEqual(to: ei(1)))
        #expect(fr(35, 10).ceiling().isEqual(to: ei(4)))
        #expect(fr(43, 10).ceiling().isEqual(to: ei(5)))
        #expect(fr(50, 10).ceiling().isEqual(to: ei(5)))
    }

    @Test
    func debugDescription() {
        #expect(fr(3, 4).debugDescription == "fraction<small<3>, small<4>>")
        #expect(fr(-1, 2).debugDescription == "fraction<small<-1>, small<2>>")
        #expect(fr(0, 1).debugDescription == "fraction<small<0>, small<1>>")
    }

    @Test
    func denominator() {
        #expect(fr(3, 4).denominator.isEqual(to: ei(4)))
        #expect(fr(1, 1).denominator.isEqual(to: ei(1)))
        #expect(fr(7, 3).denominator.isEqual(to: ei(3)))
    }

    @Test
    func description() {
        #expect(fr(3, 4).description == "3/4")
        #expect(fr(-1, 2).description == "-1/2")
        #expect(fr(0, 1).description == "0/1")
        #expect(fr(7, 3).description == "7/3")
    }

    @Test
    func divided_by() {
        #expect(fr(2, 3).divided(by: fr(1, 6)).isEqual(to: fr(4, 1)))
    }

    @Test
    func exactIntegerValue() {
        #expect(fr(10, 5).exactIntegerValue.isEqual(to: ei(2)))
        #expect(fr(7, 3).exactIntegerValue.isEqual(to: ei(2)))
        #expect(fr(0, 5).exactIntegerValue.isEqual(to: ei(0)))
        #expect(fr(-7, 2).exactIntegerValue.isEqual(to: ei(-3)))
    }

    @Test
    func floatingPointValue() {
        #expect(fr(1, 2).floatingPointValue.doubleValue == 0.5)
        #expect(fr(1, 4).floatingPointValue.doubleValue == 0.25)
        #expect(fr(-3, 4).floatingPointValue.doubleValue == -0.75)
        #expect(fr(1, 1).floatingPointValue.doubleValue == 1.0)
    }

    @Test
    func floor() {
        #expect(fr(-50, 10).floor().isEqual(to: ei(-5)))
        #expect(fr(-43, 10).floor().isEqual(to: ei(-5)))
        #expect(fr(-35, 10).floor().isEqual(to: ei(-4)))
        #expect(fr(-5, 10).floor().isEqual(to: ei(-1)))
        #expect(fr(0, 10).floor().isEqual(to: ei(0)))
        #expect(fr(5, 10).floor().isEqual(to: ei(0)))
        #expect(fr(35, 10).floor().isEqual(to: ei(3)))
        #expect(fr(43, 10).floor().isEqual(to: ei(4)))
        #expect(fr(50, 10).floor().isEqual(to: ei(5)))
    }

    @Test
    func init_numerator_denominator_reduce() {
        let reduced = Fraction(numerator: ei(4), denominator: ei(8))

        #expect(reduced.numerator.isEqual(to: ei(1)))
        #expect(reduced.denominator.isEqual(to: ei(2)))

        let unreduced = Fraction(numerator: ei(4), denominator: ei(8), reduce: false)

        #expect(unreduced.numerator.isEqual(to: ei(4)))
        #expect(unreduced.denominator.isEqual(to: ei(8)))

        let negDen = Fraction(numerator: ei(3), denominator: ei(-4))

        #expect(negDen.numerator.isEqual(to: ei(-3)))
        #expect(negDen.denominator.isEqual(to: ei(4)))

        let zeroNum = Fraction(numerator: ei(0), denominator: ei(5))

        #expect(zeroNum.numerator.isEqual(to: ei(0)))
        #expect(zeroNum.denominator.isEqual(to: ei(1)))
    }

    @Test
    func isEqual_to() {
        #expect(fr(1, 2).isEqual(to: fr(1, 2)))
        #expect(fr(2, 4).isEqual(to: fr(1, 2)))
        #expect(fr(0, 1).isEqual(to: fr(0, 3)))
        #expect(!fr(1, 2).isEqual(to: fr(1, 3)))
        #expect(!fr(1, 2).isEqual(to: fr(2, 3)))
    }

    @Test
    func isInteger() {
        #expect(fr(4, 1).isInteger)
        #expect(fr(0, 1).isInteger)
        #expect(fr(6, 3).isInteger)
        #expect(!fr(1, 2).isInteger)
        #expect(!fr(7, 3).isInteger)
    }

    @Test
    func isLess_than() {
        #expect(fr(5, 8).isLess(than: fr(3, 4)))
    }

    @Test
    func isNegative() {
        #expect(fr(-1, 2).isNegative)
        #expect(fr(-5, 3).isNegative)
        #expect(!fr(1, 2).isNegative)
        #expect(!fr(0, 1).isNegative)
    }

    @Test
    func isPositive() {
        #expect(fr(1, 2).isPositive)
        #expect(fr(5, 3).isPositive)
        #expect(!fr(-1, 2).isPositive)
        #expect(!fr(0, 1).isPositive)
    }

    @Test
    func isZero() {
        #expect(fr(0, 1).isZero)
        #expect(fr(0, 5).isZero)
        #expect(!fr(1, 2).isZero)
        #expect(!fr(-1, 2).isZero)
    }

    @Test
    func multiplied_by() {
        #expect(fr(2, 3).multiplied(by: fr(1, 6)).isEqual(to: fr(1, 9)))
    }

    @Test
    func negated() {
        #expect(fr(3, 4).negated().isEqual(to: fr(-3, 4)))
        #expect(fr(-3, 4).negated().isEqual(to: fr(3, 4)))
        #expect(fr(0, 1).negated().isEqual(to: fr(0, 1)))
        #expect(fr(1, 2).negated().negated().isEqual(to: fr(1, 2)))
    }

    @Test
    func numerator() {
        #expect(fr(3, 4).numerator.isEqual(to: ei(3)))
        #expect(fr(-1, 2).numerator.isEqual(to: ei(-1)))
        #expect(fr(0, 5).numerator.isEqual(to: ei(0)))
    }

    @Test
    func parse_radix() {
        #expect(Fraction.parse(input: "3/4", radix: .decimal)?.isEqual(to: fr(3, 4)) == true)
        #expect(Fraction.parse(input: "-7/8", radix: .decimal)?.isEqual(to: fr(-7, 8)) == true)
        #expect(Fraction.parse(input: "0/1", radix: .decimal)?.isEqual(to: fr(0, 1)) == true)
        #expect(Fraction.parse(input: "10/3", radix: .decimal)?.isEqual(to: fr(10, 3)) == true)
        #expect(Fraction.parse(input: "11/100", radix: .binary)?.isEqual(to: fr(3, 4)) == true)
        #expect(Fraction.parse(input: "a/b", radix: .hexadecimal)?.isEqual(to: fr(10, 11)) == true)
        #expect(Fraction.parse(input: "7/10", radix: .octal)?.isEqual(to: fr(7, 8)) == true)
        #expect(Fraction.parse(input: "invalid", radix: .decimal) == nil)
        #expect(Fraction.parse(input: "", radix: .decimal) == nil)
    }

    @Test
    func round() {
        #expect(fr(-50, 10).round().isEqual(to: ei(-5)))
        #expect(fr(-43, 10).round().isEqual(to: ei(-4)))
        #expect(fr(-35, 10).round().isEqual(to: ei(-4)))
        #expect(fr(-5, 10).round().isEqual(to: ei(0)))
        #expect(fr(0, 10).round().isEqual(to: ei(0)))
        #expect(fr(5, 10).round().isEqual(to: ei(0)))
        #expect(fr(35, 10).round().isEqual(to: ei(4)))
        #expect(fr(43, 10).round().isEqual(to: ei(4)))
        #expect(fr(50, 10).round().isEqual(to: ei(5)))
    }

    @Test
    func subtracting() {
        #expect(fr(2, 3).subtracting(fr(1, 6)).isEqual(to: fr(1, 2)))
    }

    @Test
    func truncate() {
        #expect(fr(-50, 10).truncate().isEqual(to: ei(-5)))
        #expect(fr(-43, 10).truncate().isEqual(to: ei(-4)))
        #expect(fr(-35, 10).truncate().isEqual(to: ei(-3)))
        #expect(fr(-5, 10).truncate().isEqual(to: ei(0)))
        #expect(fr(0, 10).truncate().isEqual(to: ei(0)))
        #expect(fr(5, 10).truncate().isEqual(to: ei(0)))
        #expect(fr(35, 10).truncate().isEqual(to: ei(3)))
        #expect(fr(43, 10).truncate().isEqual(to: ei(4)))
        #expect(fr(50, 10).truncate().isEqual(to: ei(5)))
    }
}
