// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberRepresentableTests {
}

// MARK: -

extension NumberRepresentableTests {
    @Test
    func test_codableRoundTrip() throws {
        let original: TestNumberType = 42
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestNumberType.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func test_comparable() {
        let a: TestNumberType = 3
        let b: TestNumberType = 7

        #expect(a < b)
        #expect(!(b < a))
    }

    @Test
    func test_description() {
        let value: TestNumberType = 42

        #expect(value.description == "42")
    }

    @Test
    func test_equality() {
        let a: TestNumberType = 10
        let b: TestNumberType = 10

        #expect(a == b)
    }

    @Test
    func test_expressibleByIntegerLiteral() {
        let v: TestNumberType = 10

        #expect(v.numberValue == Number(10))
    }

    @Test
    func test_inequality() {
        let a: TestNumberType = 10
        let b: TestNumberType = 20

        #expect(a != b)
    }

    @Test
    func test_initInvalidValue() {
        let result = TestNumberType(numberValue: Number(-5))

        #expect(result == nil)
    }

    @Test
    func test_initValidValue() {
        let result = TestNumberType(numberValue: Number(10))

        #expect(result != nil)
        #expect(result?.numberValue == Number(10))
    }

    @Test
    func test_intValue() {
        let value: TestNumberType = 42

        #expect(value.intValue == 42)
    }

    @Test
    func test_isValid() {
        #expect(TestNumberType.isValid(Number(0)))
        #expect(TestNumberType.isValid(Number(5)))
        #expect(!TestNumberType.isValid(Number(-1)))
        #expect(!TestNumberType.isValid(Number(numerator: 3, denominator: 4)))
    }
}

// MARK: - Test Helpers

private struct TestNumberType: NumberRepresentable {
    static func isValid(_ numberValue: Number) -> Bool {
        numberValue.isInteger && !numberValue.isNegative
    }

    init?(numberValue: Number) {
        guard Self.isValid(numberValue)
        else { return nil }

        self.numberValue = numberValue
    }

    let numberValue: Number
}
