// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct ExactIntegerTests {
}

// MARK: -

extension ExactIntegerTests {
    @Test
    func test_adding() {
        #expect(ei(3).adding(ei(4)).isEqual(to: ei(7)))
        #expect(ei(-3).adding(ei(4)).isEqual(to: ei(1)))
        #expect(ei(0).adding(ei(5)).isEqual(to: ei(5)))
        #expect(ei(-3).adding(ei(-4)).isEqual(to: ei(-7)))
        let large = ei(Int.max).adding(ei(1))
        #expect(large.adding(ei(-1)).isEqual(to: ei(Int.max)))
    }

    @Test
    func test_bitwiseAnd_with() {
        #expect(ei(0b1100).bitwiseAnd(with: ei(0b1010)).isEqual(to: ei(0b1000)))
        #expect(ei(0xff).bitwiseAnd(with: ei(0x0f)).isEqual(to: ei(0x0f)))
        #expect(ei(0).bitwiseAnd(with: ei(42)).isEqual(to: ei(0)))
        #expect(ei(-1).bitwiseAnd(with: ei(42)).isEqual(to: ei(42)))
    }

    @Test
    func test_bitwiseNot() {
        #expect(ei(0).bitwiseNot().isEqual(to: ei(-1)))
        #expect(ei(-1).bitwiseNot().isEqual(to: ei(0)))
        #expect(ei(42).bitwiseNot().isEqual(to: ei(-43)))
    }

    @Test
    func test_bitwiseOr_with() {
        #expect(ei(0b1100).bitwiseOr(with: ei(0b1010)).isEqual(to: ei(0b1110)))
        #expect(ei(0).bitwiseOr(with: ei(42)).isEqual(to: ei(42)))
        #expect(ei(0xff).bitwiseOr(with: ei(0x0f)).isEqual(to: ei(0xff)))
    }

    @Test
    func test_bitwiseShiftLeft_bits() {
        #expect(ei(1).bitwiseShiftLeft(bits: 3).isEqual(to: ei(8)))
        #expect(ei(5).bitwiseShiftLeft(bits: 0).isEqual(to: ei(5)))
        #expect(ei(3).bitwiseShiftLeft(bits: 4).isEqual(to: ei(48)))
    }

    @Test
    func test_bitwiseShiftRight_bits() {
        #expect(ei(8).bitwiseShiftRight(bits: 3).isEqual(to: ei(1)))
        #expect(ei(5).bitwiseShiftRight(bits: 0).isEqual(to: ei(5)))
        #expect(ei(48).bitwiseShiftRight(bits: 4).isEqual(to: ei(3)))
    }

    @Test
    func test_bitwiseXor_with() {
        #expect(ei(0b1100).bitwiseXor(with: ei(0b1010)).isEqual(to: ei(0b0110)))
        #expect(ei(42).bitwiseXor(with: ei(0)).isEqual(to: ei(42)))
        #expect(ei(42).bitwiseXor(with: ei(42)).isEqual(to: ei(0)))
    }

    @Test
    func test_compare_to() {
        #expect(ei(1).isLess(than: ei(2)))
        #expect(!ei(2).isLess(than: ei(1)))
        #expect(!ei(1).isLess(than: ei(1)))
        #expect(ei(-1).isLess(than: ei(0)))
        #expect(ei(0).isLess(than: ei(1)))
        let large = ei(Int.max).adding(ei(1))
        #expect(ei(Int.max).isLess(than: large))
    }

    @Test
    func test_debugDescription() {
        #expect(String(reflecting: ei(42)) == "small<42>")
        #expect(String(reflecting: ei(-7)) == "small<-7>")
        #expect(String(reflecting: ei(0)) == "small<0>")
        let large = ei(Int.max).adding(ei(1))
        #expect(String(reflecting: large).hasPrefix("large<"))
    }

    @Test
    func test_description() {
        #expect(String(describing: ei(42)) == "42")
        #expect(String(describing: ei(-7)) == "-7")
        #expect(String(describing: ei(0)) == "0")
        #expect(String(describing: ExactInteger.one) == "1")
        #expect(String(describing: ExactInteger.zero) == "0")
    }

    @Test
    func test_floatingPointValue() {
        #expect(ei(42).floatingPointValue.doubleValue == 42.0)
        #expect(ei(-7).floatingPointValue.doubleValue == -7.0)
        #expect(ei(0).floatingPointValue.doubleValue == 0.0)
    }

    @Test
    func test_greatestCommonDivisor_with() {
        #expect(ei(32).greatestCommonDivisor(with: ei(-36)).isEqual(to: ei(4)))
    }

    @Test
    func test_init_binaryFloatingPoint() {
        #expect(ExactInteger(3.0).isEqual(to: ei(3)))
        #expect(ExactInteger(-5.0).isEqual(to: ei(-5)))
        #expect(ExactInteger(0.0).isEqual(to: ei(0)))
        #expect(ExactInteger(100.0).isEqual(to: ei(100)))
    }

    @Test
    func test_init_binaryInteger() {
        #expect(ExactInteger(42).isEqual(to: ei(42)))
        #expect(ExactInteger(-7).isEqual(to: ei(-7)))
        #expect(ExactInteger(0).isEqual(to: ei(0)))
        #expect(ExactInteger(Int.max).intValue == Int.max)
        #expect(ExactInteger(Int.min).intValue == Int.min)
    }

    @Test
    func test_int16Value() {
        #expect(ei(42).int16Value == 42)
        #expect(ei(-7).int16Value == -7)
        #expect(ei(0).int16Value == 0)
    }

    @Test
    func test_int32Value() {
        #expect(ei(42).int32Value == 42)
        #expect(ei(-7).int32Value == -7)
        #expect(ei(0).int32Value == 0)
    }

    @Test
    func test_int64Value() {
        #expect(ei(42).int64Value == 42)
        #expect(ei(-7).int64Value == -7)
        #expect(ei(0).int64Value == 0)
    }

    @Test
    func test_int8Value() {
        #expect(ei(42).int8Value == 42)
        #expect(ei(-7).int8Value == -7)
        #expect(ei(0).int8Value == 0)
    }

    @Test
    func test_intValue() {
        #expect(ei(42).intValue == 42)
        #expect(ei(-7).intValue == -7)
        #expect(ei(0).intValue == 0)
        #expect(ei(Int.max).intValue == Int.max)
        #expect(ei(Int.min).intValue == Int.min)
    }

    @Test
    func test_isEqual_to() {
        #expect(ei(42).isEqual(to: ei(42)))
        #expect(!ei(42).isEqual(to: ei(43)))
        #expect(ei(0).isEqual(to: ei(0)))
        #expect(ei(-7).isEqual(to: ei(-7)))
        #expect(!ei(-7).isEqual(to: ei(7)))
    }

    @Test
    func test_isEven() {
        #expect(ei(0).isEven)
        #expect(ei(2).isEven)
        #expect(ei(-4).isEven)
        #expect(!ei(1).isEven)
        #expect(!ei(-3).isEven)
    }

    @Test
    func test_isMultiple_of() {
        #expect(ei(6).isMultiple(of: ei(3)))
        #expect(ei(0).isMultiple(of: ei(5)))
        #expect(!ei(7).isMultiple(of: ei(3)))
        #expect(ei(10).isMultiple(of: ei(1)))
        #expect(ei(-6).isMultiple(of: ei(3)))
    }

    @Test
    func test_isNegative() {
        #expect(ei(-1).isNegative)
        #expect(ei(-100).isNegative)
        #expect(!ei(0).isNegative)
        #expect(!ei(1).isNegative)
        #expect(!ei(42).isNegative)
    }

    @Test
    func test_isOdd() {
        #expect(ei(1).isOdd)
        #expect(ei(-3).isOdd)
        #expect(!ei(0).isOdd)
        #expect(!ei(2).isOdd)
        #expect(!ei(-4).isOdd)
    }

    @Test
    func test_isPositive() {
        #expect(ei(1).isPositive)
        #expect(ei(42).isPositive)
        #expect(!ei(0).isPositive)
        #expect(!ei(-1).isPositive)
        #expect(!ei(-42).isPositive)
    }

    @Test
    func test_isZero() {
        #expect(ei(0).isZero)
        #expect(ExactInteger.zero.isZero)
        #expect(!ei(1).isZero)
        #expect(!ei(-1).isZero)
        #expect(!ei(42).isZero)
    }

    @Test
    func test_leastCommonMultiple_with() {
        #expect(ei(32).leastCommonMultiple(with: ei(-36)).isEqual(to: ei(288)))
    }

    @Test
    func test_modulo() {
        #expect(ei(13).modulo(ei(4)).isEqual(to: ei(1)))
        #expect(ei(-13).modulo(ei(4)).isEqual(to: ei(3)))
        #expect(ei(13).modulo(ei(-4)).isEqual(to: ei(-3)))
        #expect(ei(-13).modulo(ei(-4)).isEqual(to: ei(-1)))
    }

    @Test
    func test_multiplied_by() {
        #expect(ei(3).multiplied(by: ei(4)).isEqual(to: ei(12)))
        #expect(ei(-3).multiplied(by: ei(4)).isEqual(to: ei(-12)))
        #expect(ei(0).multiplied(by: ei(42)).isEqual(to: ei(0)))
        #expect(ei(1).multiplied(by: ei(7)).isEqual(to: ei(7)))
        let large = ei(Int.max).multiplied(by: ei(2))
        #expect(large.isEqual(to: ei(Int.max).adding(ei(Int.max))))
    }

    @Test
    func test_negated() {
        #expect(ei(42).negated().isEqual(to: ei(-42)))
        #expect(ei(-7).negated().isEqual(to: ei(7)))
        #expect(ei(0).negated().isEqual(to: ei(0)))
        #expect(ei(1).negated().negated().isEqual(to: ei(1)))
    }

    @Test
    func test_parse_radix() {
        #expect(ExactInteger.parse(input: "42", radix: .decimal)?.isEqual(to: ei(42)) == true)
        #expect(ExactInteger.parse(input: "-7", radix: .decimal)?.isEqual(to: ei(-7)) == true)
        #expect(ExactInteger.parse(input: "0", radix: .decimal)?.isEqual(to: ei(0)) == true)
        #expect(ExactInteger.parse(input: "101010", radix: .binary)?.isEqual(to: ei(42)) == true)
        #expect(ExactInteger.parse(input: "-101", radix: .binary)?.isEqual(to: ei(-5)) == true)
        #expect(ExactInteger.parse(input: "2a", radix: .hexadecimal)?.isEqual(to: ei(42)) == true)
        #expect(ExactInteger.parse(input: "ff", radix: .hexadecimal)?.isEqual(to: ei(255)) == true)
        #expect(ExactInteger.parse(input: "52", radix: .octal)?.isEqual(to: ei(42)) == true)
        #expect(ExactInteger.parse(input: "xyz", radix: .decimal) == nil)
        #expect(ExactInteger.parse(input: "29", radix: .octal) == nil)
        #expect(ExactInteger.parse(input: "2g", radix: .hexadecimal) == nil)
    }

    @Test
    func test_quotient_dividingBy() {
        #expect(ei(12).quotient(dividingBy: ei(4)).isEqual(to: ei(3)))
        #expect(ei(13).quotient(dividingBy: ei(4)).isEqual(to: ei(3)))
        #expect(ei(-12).quotient(dividingBy: ei(4)).isEqual(to: ei(-3)))
        #expect(ei(0).quotient(dividingBy: ei(5)).isEqual(to: ei(0)))
    }

    @Test
    func test_remainder_dividingBy() {
        #expect(ei(13).remainder(dividingBy: ei(4)).isEqual(to: ei(1)))
        #expect(ei(-13).remainder(dividingBy: ei(4)).isEqual(to: ei(-1)))
        #expect(ei(13).remainder(dividingBy: ei(-4)).isEqual(to: ei(1)))
        #expect(ei(-13).remainder(dividingBy: ei(-4)).isEqual(to: ei(-1)))
    }

    @Test
    func test_subtracting() {
        #expect(ei(7).subtracting(ei(3)).isEqual(to: ei(4)))
        #expect(ei(3).subtracting(ei(7)).isEqual(to: ei(-4)))
        #expect(ei(0).subtracting(ei(0)).isEqual(to: ei(0)))
        #expect(ei(-3).subtracting(ei(-7)).isEqual(to: ei(4)))
        let large = ei(Int.max).adding(ei(1))
        #expect(large.subtracting(ei(1)).isEqual(to: ei(Int.max)))
    }

    @Test
    func test_uint16Value() {
        #expect(ei(42).uint16Value == 42)
        #expect(ei(0).uint16Value == 0)
        #expect(ei(255).uint16Value == 255)
    }

    @Test
    func test_uint32Value() {
        #expect(ei(42).uint32Value == 42)
        #expect(ei(0).uint32Value == 0)
        #expect(ei(100_000).uint32Value == 100_000)
    }

    @Test
    func test_uint64Value() {
        #expect(ei(42).uint64Value == 42)
        #expect(ei(0).uint64Value == 0)
        #expect(ei(Int.max).uint64Value == UInt64(Int.max))
    }

    @Test
    func test_uint8Value() {
        #expect(ei(42).uint8Value == 42)
        #expect(ei(0).uint8Value == 0)
        #expect(ei(255).uint8Value == 255)
    }

    @Test
    func test_uintValue() {
        #expect(ei(42).uintValue == 42)
        #expect(ei(0).uintValue == 0)
        #expect(ei(Int.max).uintValue == UInt(Int.max))
    }
}
