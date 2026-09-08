// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberFormatStyleParseStrategyTests {
    private let posixLocale = Locale(identifier: "en_US_POSIX")
    private let usLocale = Locale(identifier: "en_US")
}

// MARK: -

extension NumberFormatStyleParseStrategyTests {
    @Test
    func parse_complex() throws {
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(1...3)

        #expect(try fs.parseStrategy.parse("123+4,567i") == ncx(123, 4_567))
        #expect(try fs.parseStrategy.parse("123.0+4,567.0i") == ncx(123.0, 4_567))
        #expect(try fs.parseStrategy.parse("1,234+0i") == ncx(1_234, 0))
        #expect(try fs.parseStrategy.parse("1,234-1i") == ncx(1_234, -1))
        #expect(try fs.parseStrategy.parse("-1,234-1i") == ncx(-1_234, -1))
    }

    @Test
    func parse_exactInteger() throws {
        let fs = Number.FormatStyle(locale: usLocale)

        #expect(try fs.parseStrategy.parse("123") == 123)
        #expect(try fs.parseStrategy.parse("1,234") == 1_234)
        #expect(try fs.parseStrategy.parse("5,836,472") == 5_836_472)
        #expect(try fs.parseStrategy.parse("-5,836,472") == -5_836_472)
        #expect(try fs.parseStrategy.parse("12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890")
                == Number("12345678901234567890123456789012345678901234567890"))
        #expect(try fs.parseStrategy.parse("-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890")
                == Number("-12345678901234567890123456789012345678901234567890"))
    }

    @Test
    func parse_exactInteger_posix() throws {
        let fs = Number.FormatStyle(locale: posixLocale)

        #expect(try fs.parseStrategy.parse("123") == 123)
        #expect(try fs.parseStrategy.parse("1234") == 1_234)
        #expect(try fs.parseStrategy.parse("5836472") == 5_836_472)
        #expect(try fs.parseStrategy.parse("-5836472") == -5_836_472)
        #expect(try fs.parseStrategy.parse("12345678901234567890123456789012345678901234567890")
                == Number("12345678901234567890123456789012345678901234567890"))
        #expect(try fs.parseStrategy.parse("-12345678901234567890123456789012345678901234567890")
                == Number("-12345678901234567890123456789012345678901234567890"))
    }

    @Test
    func parse_floatingPoint() throws {
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(1...3)

        #expect(try fs.parseStrategy.parse("123.0") == Number(123.0))
        #expect(try fs.parseStrategy.parse("1,234.25") == Number(1_234.25))
        #expect(try fs.parseStrategy.parse("5,836,472.375") == Number(5_836_472.375))
        #expect(try fs.parseStrategy.parse("-5,836,472.613") == Number(-5_836_472.613))
        #expect(try fs.parseStrategy.parse("∞") == .positiveInfinity)
        #expect(try fs.parseStrategy.parse("-∞") == .negativeInfinity)
        #expect(try fs.parseStrategy.parse("NaN").doubleValue.isNaN)
    }

    @Test
    func parse_floatingPoint_posix() throws {
        let fs = Number.FormatStyle(locale: posixLocale).decimalPrecision(1...3)

        #expect(try fs.parseStrategy.parse("123.0") == Number(123.0))
        #expect(try fs.parseStrategy.parse("1234.25") == Number(1_234.25))
        #expect(try fs.parseStrategy.parse("INF") == .positiveInfinity)
        #expect(try fs.parseStrategy.parse("-INF") == .negativeInfinity)
        #expect(try fs.parseStrategy.parse("NaN").doubleValue.isNaN)
    }

    @Test
    func parse_fraction_decimal() throws {
        // Decimal fraction display never round-trips back to an exact
        // fraction — it's indistinguishable from an ordinary floating-point
        // number, so it parses as one.
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(0...3).fractionDisplay(strategy: .decimal)

        #expect(try fs.parseStrategy.parse("0.027") == Number(0.027))
        #expect(try fs.parseStrategy.parse("4,012.") == Number(4_012.0))
        #expect(try fs.parseStrategy.parse("-0.09") == Number(-0.09))
    }

    @Test
    func parse_fraction_default() throws {
        let fs = Number.FormatStyle(locale: usLocale) // == .fractionDisplay(strategy: .simple(alwaysShowDenominator: true))

        #expect(try fs.parseStrategy.parse("123/4,567") == nfr(123, 4_567))
        #expect(try fs.parseStrategy.parse("1,234/56,789") == nfr(1_234, 56_789))
        #expect(try fs.parseStrategy.parse("4,012/1") == nfr(4_012, 1))
        #expect(try fs.parseStrategy.parse("-583/6,472") == nfr(-583, 6_472))
        #expect(try fs.parseStrategy.parse("4,012/9") == nfr(4_012, 9))
    }

    @Test
    func parse_fraction_mixed_default() throws {
        let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: .mixed())   // == .mixed(alwaysShowInteger: false)

        #expect(try fs.parseStrategy.parse("123/4,567") == nfr(123, 4_567))
        #expect(try fs.parseStrategy.parse("1,234/56,789") == nfr(1_234, 56_789))
        #expect(try fs.parseStrategy.parse("-583/6,472") == nfr(-583, 6_472))
        #expect(try fs.parseStrategy.parse("445 7/9") == nfr(4_012, 9))
        #expect(try fs.parseStrategy.parse("-445 7/9") == nfr(-4_012, 9))
        #expect(try fs.parseStrategy.parse("0") == 0)   // bare integer, not a fraction shape
    }

    @Test
    func parse_fraction_mixed_true() throws {
        let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: .mixed(alwaysShowInteger: true))

        #expect(try fs.parseStrategy.parse("0 123/4,567") == nfr(123, 4_567))
        #expect(try fs.parseStrategy.parse("0 1,234/56,789") == nfr(1_234, 56_789))
        #expect(try fs.parseStrategy.parse("-0 583/6,472") == nfr(-583, 6_472))
        #expect(try fs.parseStrategy.parse("445 7/9") == nfr(4_012, 9))
        #expect(try fs.parseStrategy.parse("-445 7/9") == nfr(-4_012, 9))
    }

    @Test
    func parse_fraction_ratio() throws {
        let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: .ratio)

        #expect(try fs.parseStrategy.parse("123:4,567") == nfr(123, 4_567))
        #expect(try fs.parseStrategy.parse("1,234:56,789") == nfr(1_234, 56_789))
        #expect(try fs.parseStrategy.parse("4,012:1") == nfr(4_012, 1))
        #expect(try fs.parseStrategy.parse("-583:6,472") == nfr(-583, 6_472))
    }

    @Test
    func parse_fraction_simple_false() throws {
        let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: .simple(alwaysShowDenominator: false))

        #expect(try fs.parseStrategy.parse("123/4,567") == nfr(123, 4_567))
        #expect(try fs.parseStrategy.parse("4,012") == nfr(4_012, 1))
        #expect(try fs.parseStrategy.parse("-583/6,472") == nfr(-583, 6_472))
    }

    @Test
    func parse_grouping_false() throws {
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(1...3).grouping(false)

        #expect(try fs.parseStrategy.parse("1234") == 1_234)
        #expect(try fs.parseStrategy.parse("-5836472") == -5_836_472)
        #expect(try fs.parseStrategy.parse("12345678901234567890123456789012345678901234567890")
                == Number("12345678901234567890123456789012345678901234567890"))
        #expect(try fs.parseStrategy.parse("1234.25") == Number(1_234.25))
        #expect(try fs.parseStrategy.parse("1234/56789") == nfr(1_234, 56_789))
    }

    @Test
    func parse_invalid() {
        let fs = Number.FormatStyle(locale: usLocale)

        #expect(throws: Number.FormatStyle.ParseError(input: "")) {
            try fs.parseStrategy.parse("")
        }

        #expect(throws: Number.FormatStyle.ParseError(input: "not a number")) {
            try fs.parseStrategy.parse("not a number")
        }

        #expect(throws: Number.FormatStyle.ParseError(input: "123/0")) {
            try fs.parseStrategy.parse("123/0")   // zero denominator
        }
    }

    @Test
    func parse_number_initializer() throws {
        #expect(try Number("1,234", format: Number.FormatStyle(locale: usLocale)) == 1_234)
        #expect(try Number("1,234", strategy: Number.FormatStyle(locale: usLocale).parseStrategy) == 1_234)
    }

    @Test
    func roundTrip() throws {
        // Values with no exact fraction involved round-trip exactly under
        // every fraction display strategy, since `fractionDisplay` only
        // governs how fractions are shown.
        let strategies: [Number.FractionDisplayStrategy] = [.decimal,
                                                            .ratio,
                                                            .mixed(),
                                                            .mixed(alwaysShowInteger: true),
                                                            .simple(),
                                                            .simple(alwaysShowDenominator: false)]
        let values: [Number] = [123,
                                -123,
                                0,
                                1_234.5,
                                -1_234.5,
                                ncx(123, 456),
                                ncx(-123, -456)]

        for strategy in strategies {
            let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(1...6).fractionDisplay(strategy: strategy)

            for value in values {
                let formatted = fs.format(value)
                let parsed = try fs.parseStrategy.parse(formatted)

                #expect(parsed == value,
                        "\(strategy): expected \(value) from \"\(formatted)\", got \(parsed)")
            }
        }
    }

    @Test
    func roundTrip_fraction() throws {
        // Exact fractions round-trip exactly only under a fraction display
        // strategy that preserves numerator/denominator shape; `.decimal`
        // display is intentionally excluded here, since it collapses a
        // fraction into a (precision-limited) decimal approximation.
        let strategies: [Number.FractionDisplayStrategy] = [.ratio,
                                                            .mixed(),
                                                            .mixed(alwaysShowInteger: true),
                                                            .simple(),
                                                            .simple(alwaysShowDenominator: false)]
        let values: [Number] = [nfr(4_012, 9),
                                nfr(-4_012, 9),
                                nfr(0, 1),
                                nfr(4_012, 1)]

        for strategy in strategies {
            let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: strategy)

            for value in values {
                let formatted = fs.format(value)
                let parsed = try fs.parseStrategy.parse(formatted)

                #expect(parsed == value,
                        "\(strategy): expected \(value) from \"\(formatted)\", got \(parsed)")
            }
        }
    }
}
