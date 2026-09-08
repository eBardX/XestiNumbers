// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberFormatStyleParseErrorTests {
}

// MARK: -

extension NumberFormatStyleParseErrorTests {
    @Test
    func description() {
        let error = Number.FormatStyle.ParseError(input: "xyz")

        #expect(error.description == "invalid number: \"xyz\"")
    }

    @Test
    func equality() {
        let error1 = Number.FormatStyle.ParseError(input: "xyz")
        let error2 = Number.FormatStyle.ParseError(input: "xyz")

        #expect(error1 == error2)
    }

    @Test
    func error() {
        #expect(throws: Number.FormatStyle.ParseError.self) {
            throw Number.FormatStyle.ParseError(input: "xyz")
        }
    }

    @Test
    func inequality() {
        let error1 = Number.FormatStyle.ParseError(input: "xyz")
        let error2 = Number.FormatStyle.ParseError(input: "abc")

        #expect(error1 != error2)
    }

    @Test
    func input() {
        let error = Number.FormatStyle.ParseError(input: "xyz")

        #expect(error.input == "xyz")
    }
}
