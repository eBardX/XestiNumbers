// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberTests {
}

// MARK: -

extension NumberTests {
    @Test
    func codable_roundTrip() throws {
        let original = Number(42)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Number.self, from: data)

        #expect(decoded == original)

        let fraction: Number = "3/4"
        let fracData = try JSONEncoder().encode(fraction)
        let fracDecoded = try JSONDecoder().decode(Number.self, from: fracData)

        #expect(fracDecoded == fraction)
    }

    @Test
    func comparable() {
        let a = Number(1)
        let b = Number(2)
        let c = Number(3)

        #expect(a < b)
        #expect(b < c)
        #expect(!(b < a))

        let a2 = Number(1)

        #expect(!(a < a2))
    }

    @Test
    func debugDescription() {
        let integer = Number(42)

        #expect(!integer.debugDescription.isEmpty)

        let complex = Number(realPart: Number(3), imaginaryPart: Number(4))

        #expect(!complex.debugDescription.isEmpty)
    }

    @Test
    func description() {
        let integer = Number(42)

        #expect(integer.description == "42")

        let fraction = Number(numerator: 3, denominator: 4)

        #expect(fraction.description == "3/4")

        let float = Number(3.14)

        #expect(float.description.hasPrefix("3.14"))

        let complex = Number(realPart: Number(3), imaginaryPart: Number(4))

        #expect(!complex.description.isEmpty)
    }

    @Test
    func equality_exactIntegers() {
        let a = Number(42)
        let b = Number(42)
        let c = Number(99)

        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func equality_mixedTypes() {
        let real = Number(5)
        let complex = Number(realPart: Number(5), imaginaryPart: Number(0))

        #expect(real == complex)
    }

    @Test
    func expressibleByFloatLiteral() {
        let n: Number = 3.14

        #expect(!n.isExact)
        #expect(n.doubleValue.isApproximatelyEqual(to: 3.14))
    }

    @Test
    func expressibleByIntegerLiteral() {
        let n: Number = 42

        #expect(n.isExact)
        #expect(n == Number(42))
    }

    @Test
    func expressibleByStringLiteral() {
        let n: Number = "3/4"

        #expect(n == Number(numerator: 3, denominator: 4))
    }

    @Test
    func hashable() {
        let a = Number(42)
        let b = Number(42)

        #expect(a.hashValue == b.hashValue)

        let set: Set<Number> = [a, b]

        #expect(set.count == 1)
    }

    @Test
    func hashable_exactInexactEquality() {
        let exact = Number(1)
        let inexact = Number(1.0)

        #expect(exact == inexact)
        #expect(exact.hashValue == inexact.hashValue)

        let set: Set<Number> = [exact, inexact]

        #expect(set.count == 1)
    }
}
