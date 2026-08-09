// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberRepresentableTests {
}

// MARK: -

extension NumberRepresentableTests {
    @Test
    func codableRoundTrip() throws {
        let original: TestNumberType = 42
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestNumberType.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func comparable() {
        let a: TestNumberType = 3
        let b: TestNumberType = 7

        #expect(a < b)
        #expect(!(b < a))
    }

    @Test
    func description() {
        let value: TestNumberType = 42

        #expect(value.description == "42")
    }

    @Test
    func equality() {
        let a: TestNumberType = 10
        let b: TestNumberType = 10

        #expect(a == b)
    }

    @Test
    func expressibleByIntegerLiteral() {
        let v: TestNumberType = 10

        #expect(v.numberValue == Number(10))
    }

    @Test
    func inequality() {
        let a: TestNumberType = 10
        let b: TestNumberType = 20

        #expect(a != b)
    }

    @Test
    func initInvalidValue() {
        let result = TestNumberType(numberValue: Number(-5))

        #expect(result == nil)
    }

    @Test
    func initValidValue() {
        let result = TestNumberType(numberValue: Number(10))

        #expect(result != nil)
        #expect(result?.numberValue == Number(10))
    }

    @Test
    func intValue() {
        let value: TestNumberType = 42

        #expect(value.intValue == 42)
    }

    @Test
    func isValid() {
        #expect(TestNumberType.isValid(Number(0)))
        #expect(TestNumberType.isValid(Number(5)))
        #expect(!TestNumberType.isValid(Number(-1)))
        #expect(!TestNumberType.isValid(Number(numerator: 3, denominator: 4)))
    }
}
