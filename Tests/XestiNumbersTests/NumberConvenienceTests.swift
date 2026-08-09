// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberConvenienceTests {
}

// MARK: -

extension NumberConvenienceTests {
    @Test
    func doubleValue() {
        #expect(Number(42).doubleValue == 42.0)
        #expect(Number(3.14).doubleValue.isApproximatelyEqual(to: 3.14))
        #expect(Number(numerator: 1, denominator: 2).doubleValue == 0.5)
    }

    @Test
    func floatValue() {
        #expect(Number(42).floatValue == 42.0)
        #expect(Double(Number(3.14).floatValue).isApproximatelyEqual(to: 3.14, tolerance: 1e-6))
        #expect(Number(numerator: 1, denominator: 2).floatValue == 0.5)
    }

    @Test
    func init_binaryFloatingPoint() {
        let n = Number(3.14)

        #expect(!n.isExact)
        #expect(n.doubleValue.isApproximatelyEqual(to: 3.14))
    }

    @Test
    func init_binaryInteger() {
        let n = Number(42)

        #expect(n.isExact)
        #expect(n.intValue == 42)
    }

    @Test
    func init_magnitude_angle() {
        let n = Number(magnitude: Number(5), angle: Number(0))

        #expect(n == Number(5))
    }

    @Test
    func init_magnitude_angle_binaryFloatingPoint() {
        let n = Number(magnitude: 5.0, angle: 0.0)

        #expect(n.doubleValue.isApproximatelyEqual(to: 5.0))
    }

    @Test
    func init_magnitude_angle_binaryInteger() {
        let n = Number(magnitude: 5, angle: 0)

        #expect(n.doubleValue.isApproximatelyEqual(to: 5.0))
    }

    @Test
    func init_numerator_denominator() {
        let n = Number(numerator: Number(3), denominator: Number(4))

        #expect(n == Number(numerator: 3, denominator: 4))
    }

    @Test
    func init_numerator_denominator_binaryInteger() {
        let n = Number(numerator: 3, denominator: 4)

        #expect(n.description == "3/4")
    }

    @Test
    func init_realPart_imaginaryPart() {
        let n = Number(realPart: Number(3), imaginaryPart: Number(4))

        #expect(!n.description.isEmpty)
    }

    @Test
    func init_realPart_imaginaryPart_binaryFloatingPoint() {
        let n = Number(realPart: 3.0, imaginaryPart: 4.0)

        #expect(!n.description.isEmpty)
    }

    @Test
    func init_realPart_imaginaryPart_binaryInteger() {
        let n = Number(realPart: 3, imaginaryPart: 4)

        #expect(!n.description.isEmpty)
    }

    @Test
    func init_string() {
        let valid = "42"
        let fraction = "3/4"
        let invalid = "not a number"

        #expect(Number(valid) == Number(42))
        #expect(Number(fraction) == Number(numerator: 3, denominator: 4))
        #expect(Number(invalid) == nil)
    }

    @Test
    func int16Value() {
        #expect(Number(42).int16Value == 42)
        #expect(Number(-7).int16Value == -7)
    }

    @Test
    func int32Value() {
        #expect(Number(42).int32Value == 42)
        #expect(Number(-7).int32Value == -7)
    }

    @Test
    func int64Value() {
        #expect(Number(42).int64Value == 42)
        #expect(Number(-7).int64Value == -7)
    }

    @Test
    func int8Value() {
        #expect(Number(42).int8Value == 42)
        #expect(Number(-7).int8Value == -7)
    }

    @Test
    func intValue() {
        #expect(Number(42).intValue == 42)
        #expect(Number(-7).intValue == -7)
    }

    @Test
    func nan() {
        #expect(Number.nan.doubleValue.isNaN)
    }

    @Test
    func negativeInfinity() {
        #expect(Number.negativeInfinity < Number(0))
    }

    @Test
    func pi() {
        #expect(Number.pi.doubleValue.isApproximatelyEqual(to: Double.pi))
    }

    @Test
    func positiveInfinity() {
        #expect(Number.positiveInfinity > Number(0))
    }

    @Test
    func uint16Value() {
        #expect(Number(42).uint16Value == 42)
        #expect(Number(0).uint16Value == 0)
    }

    @Test
    func uint32Value() {
        #expect(Number(42).uint32Value == 42)
        #expect(Number(0).uint32Value == 0)
    }

    @Test
    func uint64Value() {
        #expect(Number(42).uint64Value == 42)
        #expect(Number(0).uint64Value == 0)
    }

    @Test
    func uint8Value() {
        #expect(Number(42).uint8Value == 42)
        #expect(Number(0).uint8Value == 0)
    }

    @Test
    func uintValue() {
        #expect(Number(42).uintValue == 42)
        #expect(Number(0).uintValue == 0)
    }
}
