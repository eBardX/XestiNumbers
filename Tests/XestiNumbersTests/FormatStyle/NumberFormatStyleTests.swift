// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberFormatStyleTests {
    private let posixLocale = Locale(identifier: "en_US_POSIX")
    private let usLocale = Locale(identifier: "en_US")
}

// MARK: -

extension NumberFormatStyleTests {
    @Test
    func format_complex() {
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(1...3)

        #expect(fs.format(ncx(123, 4_567)) == "123+4,567i")
        #expect(fs.format(ncx(123.0, 4_567)) == "123.0+4,567.0i")
        #expect(fs.format(ncx(1_234, 0)) == "1,234+0i")
        #expect(fs.format(ncx(1_234, -1)) == "1,234-1i")
    }

    @Test
    func format_complex_posix() {
        let fs = Number.FormatStyle(locale: posixLocale).decimalPrecision(1...3)

        #expect(fs.format(ncx(123, 4_567)) == "123+4567i")
        #expect(fs.format(ncx(123.0, 4_567)) == "123.0+4567.0i")
        #expect(fs.format(ncx(1_234, 0)) == "1234+0i")
        #expect(fs.format(ncx(1_234, -1)) == "1234-1i")
    }

    @Test
    func format_exactInteger() {
        let fs = Number.FormatStyle(locale: usLocale)

        #expect(fs.format(123) == "123")
        #expect(fs.format(1_234) == "1,234")
        #expect(fs.format(5_836_472) == "5,836,472")
        #expect(fs.format(-5_836_472) == "-5,836,472")
        #expect(fs.format("12345678901234567890123456789012345678901234567890")
                == "12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890")
                == "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890")
    }

    @Test
    func format_exactInteger_posix() {
        let fs = Number.FormatStyle(locale: posixLocale)

        #expect(fs.format(123) == "123")
        #expect(fs.format(1_234) == "1234")
        #expect(fs.format(5_836_472) == "5836472")
        #expect(fs.format(-5_836_472) == "-5836472")
        #expect(fs.format("12345678901234567890123456789012345678901234567890")
                == "12345678901234567890123456789012345678901234567890")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890")
                == "-12345678901234567890123456789012345678901234567890")
    }

    @Test
    func format_floatingPoint() {
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(1...3)

        #expect(fs.format(123.0) == "123.0")
        #expect(fs.format(1_234.25) == "1,234.25")
        #expect(fs.format(5_836_472.375) == "5,836,472.375")
        #expect(fs.format(-5_836_472.6125) == "-5,836,472.613")
        #expect(fs.format(.nan) == "NaN")
        #expect(fs.format(.pi) == "3.142")
        #expect(fs.format(.positiveInfinity) == "∞")
        #expect(fs.format(.negativeInfinity) == "-∞")
    }

    @Test
    func format_floatingPoint_posix() {
        let fs = Number.FormatStyle(locale: posixLocale).decimalPrecision(1...3)

        #expect(fs.format(123.0) == "123.0")
        #expect(fs.format(1_234.25) == "1234.25")
        #expect(fs.format(5_836_472.375) == "5836472.375")
        #expect(fs.format(-5_836_472.6125) == "-5836472.613")
        #expect(fs.format(.nan) == "NaN")
        #expect(fs.format(.pi) == "3.142")
        #expect(fs.format(.positiveInfinity) == "INF")
        #expect(fs.format(.negativeInfinity) == "-INF")
    }

    @Test
    func format_fraction_decimal() {
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(0...3).fractionDisplay(strategy: .decimal)

        #expect(fs.format(nfr(123, 4_567)) == "0.027")
        #expect(fs.format(nfr(1_234, 56_789)) == "0.022")
        #expect(fs.format(nfr(4_012, 1)) == "4,012.")
        #expect(fs.format(nfr(-583, 6_472)) == "-0.09")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,636,314,126,135,689,000,000,000,000,000,000,000,000,000,000.")
        #expect(fs.format(nfr(4_012, 9)) == "445.778")
        #expect(fs.format(nfr(4_012, 4)) == "1,003.")
    }

    @Test
    func format_fraction_decimal_posix() {
        let fs = Number.FormatStyle(locale: posixLocale).decimalPrecision(0...3).fractionDisplay(strategy: .decimal)

        #expect(fs.format(nfr(123, 4_567)) == "0.027")
        #expect(fs.format(nfr(1_234, 56_789)) == "0.022")
        #expect(fs.format(nfr(4_012, 1)) == "4012.")
        #expect(fs.format(nfr(-583, 6_472)) == "-0.09")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12636314126135689000000000000000000000000000000.")
        #expect(fs.format(nfr(4_012, 9)) == "445.778")
        #expect(fs.format(nfr(4_012, 4)) == "1003.")
    }

    @Test
    func format_fraction_default() {
        let fs = Number.FormatStyle(locale: usLocale) // == .fractionDisplay(strategy: .simple(alwaysShowDenominator: true))

        #expect(fs.format(nfr(123, 4_567)) == "123/4,567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1,234/56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012/1")
        #expect(fs.format(nfr(-583, 6_472)) == "-583/6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890/977")
        #expect(fs.format(nfr(4_012, 9)) == "4,012/9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003/1")
    }

    @Test
    func format_fraction_default_posix() {
        let fs = Number.FormatStyle(locale: posixLocale) // == .fractionDisplay(strategy: .simple(alwaysShowDenominator: true))

        #expect(fs.format(nfr(123, 4_567)) == "123/4567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1234/56789")
        #expect(fs.format(nfr(4_012, 1)) == "4012/1")
        #expect(fs.format(nfr(-583, 6_472)) == "-583/6472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12345678901234567890123456789012345678901234567890/977")
        #expect(fs.format(nfr(4_012, 9)) == "4012/9")
        #expect(fs.format(nfr(4_012, 4)) == "1003/1")
    }

    @Test
    func format_fraction_mixed_default() {
        let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: .mixed())   // == .mixed(alwaysShowInteger: false)

        #expect(fs.format(nfr(123, 4_567)) == "123/4,567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1,234/56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012")
        #expect(fs.format(nfr(-583, 6_472)) == "-583/6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,636,314,126,135,688,730,934,960,889,470,159,343,808,837,838 164/977")
        #expect(fs.format(nfr(4_012, 9)) == "445 7/9")
        #expect(fs.format(nfr(-4_012, 9)) == "-445 7/9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003")
        #expect(fs.format(nfr(0, 1)) == "0")
    }

    @Test
    func format_fraction_mixed_default_posix() {
        let fs = Number.FormatStyle(locale: posixLocale).fractionDisplay(strategy: .mixed())   // == .mixed(alwaysShowInteger: false)

        #expect(fs.format(nfr(123, 4_567)) == "123/4567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1234/56789")
        #expect(fs.format(nfr(4_012, 1)) == "4012")
        #expect(fs.format(nfr(-583, 6_472)) == "-583/6472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12636314126135688730934960889470159343808837838 164/977")
        #expect(fs.format(nfr(4_012, 9)) == "445 7/9")
        #expect(fs.format(nfr(-4_012, 9)) == "-445 7/9")
        #expect(fs.format(nfr(4_012, 4)) == "1003")
        #expect(fs.format(nfr(0, 1)) == "0")
    }

    @Test
    func format_fraction_mixed_true() {
        let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: .mixed(alwaysShowInteger: true))

        #expect(fs.format(nfr(123, 4_567)) == "0 123/4,567")
        #expect(fs.format(nfr(1_234, 56_789)) == "0 1,234/56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012")
        #expect(fs.format(nfr(-583, 6_472)) == "-0 583/6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,636,314,126,135,688,730,934,960,889,470,159,343,808,837,838 164/977")
        #expect(fs.format(nfr(4_012, 9)) == "445 7/9")
        #expect(fs.format(nfr(-4_012, 9)) == "-445 7/9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003")
        #expect(fs.format(nfr(0, 1)) == "0")
    }

    @Test
    func format_fraction_mixed_true_posix() {
        let fs = Number.FormatStyle(locale: posixLocale).fractionDisplay(strategy: .mixed(alwaysShowInteger: true))

        #expect(fs.format(nfr(123, 4_567)) == "0 123/4567")
        #expect(fs.format(nfr(1_234, 56_789)) == "0 1234/56789")
        #expect(fs.format(nfr(4_012, 1)) == "4012")
        #expect(fs.format(nfr(-583, 6_472)) == "-0 583/6472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12636314126135688730934960889470159343808837838 164/977")
        #expect(fs.format(nfr(4_012, 9)) == "445 7/9")
        #expect(fs.format(nfr(-4_012, 9)) == "-445 7/9")
        #expect(fs.format(nfr(4_012, 4)) == "1003")
        #expect(fs.format(nfr(0, 1)) == "0")
    }

    @Test
    func format_fraction_ratio() {
        let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: .ratio)

        #expect(fs.format(nfr(123, 4_567)) == "123:4,567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1,234:56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012:1")
        #expect(fs.format(nfr(-583, 6_472)) == "-583:6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890:977")
        #expect(fs.format(nfr(4_012, 9)) == "4,012:9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003:1")
    }

    @Test
    func format_fraction_ratio_posix() {
        let fs = Number.FormatStyle(locale: posixLocale).fractionDisplay(strategy: .ratio)

        #expect(fs.format(nfr(123, 4_567)) == "123:4567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1234:56789")
        #expect(fs.format(nfr(4_012, 1)) == "4012:1")
        #expect(fs.format(nfr(-583, 6_472)) == "-583:6472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12345678901234567890123456789012345678901234567890:977")
        #expect(fs.format(nfr(4_012, 9)) == "4012:9")
        #expect(fs.format(nfr(4_012, 4)) == "1003:1")
    }

    @Test
    func format_fraction_simple_false() {
        let fs = Number.FormatStyle(locale: usLocale).fractionDisplay(strategy: .simple(alwaysShowDenominator: false))

        #expect(fs.format(nfr(123, 4_567)) == "123/4,567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1,234/56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012")
        #expect(fs.format(nfr(-583, 6_472)) == "-583/6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890/977")
        #expect(fs.format(nfr(4_012, 9)) == "4,012/9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003")
    }

    @Test
    func format_fraction_simple_false_posix() {
        let fs = Number.FormatStyle(locale: posixLocale).fractionDisplay(strategy: .simple(alwaysShowDenominator: false))

        #expect(fs.format(nfr(123, 4_567)) == "123/4567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1234/56789")
        #expect(fs.format(nfr(4_012, 1)) == "4012")
        #expect(fs.format(nfr(-583, 6_472)) == "-583/6472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12345678901234567890123456789012345678901234567890/977")
        #expect(fs.format(nfr(4_012, 9)) == "4012/9")
        #expect(fs.format(nfr(4_012, 4)) == "1003")
    }

    @Test
    func format_grouping_false() {
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(1...3).grouping(false)

        #expect(fs.format(1_234) == "1234")
        #expect(fs.format(-5_836_472) == "-5836472")
        #expect(fs.format("12345678901234567890123456789012345678901234567890")
                == "12345678901234567890123456789012345678901234567890")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890")
                == "-12345678901234567890123456789012345678901234567890")
        #expect(fs.format(1_234.25) == "1234.25")
        #expect(fs.format(nfr(1_234, 56_789)) == "1234/56789")
    }

    @Test
    func format_grouping_false_posix() {
        let fs = Number.FormatStyle(locale: posixLocale).decimalPrecision(1...3).grouping(false)

        #expect(fs.format(1_234) == "1234")
        #expect(fs.format(-5_836_472) == "-5836472")
        #expect(fs.format("12345678901234567890123456789012345678901234567890")
                == "12345678901234567890123456789012345678901234567890")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890")
                == "-12345678901234567890123456789012345678901234567890")
        #expect(fs.format(1_234.25) == "1234.25")
        #expect(fs.format(nfr(1_234, 56_789)) == "1234/56789")
    }

    @Test
    func format_grouping_true() {
        let fs = Number.FormatStyle(locale: usLocale).decimalPrecision(1...3).grouping()

        #expect(fs.format(1_234) == "1,234")
        #expect(fs.format(-5_836_472) == "-5,836,472")
        #expect(fs.format(1_234.25) == "1,234.25")
        #expect(fs.format(nfr(1_234, 56_789)) == "1,234/56,789")
    }

    @Test
    func format_grouping_true_posix() {
        // Even though grouping is requested, `en_US_POSIX` has no automatic
        // grouping policy in ICU, so no separators are inserted regardless
        // of magnitude — for `Int`/`Double` values as well as `BigInt`.
        let fs = Number.FormatStyle(locale: posixLocale).decimalPrecision(1...3).grouping()

        #expect(fs.format(1_234) == "1234")
        #expect(fs.format(-5_836_472) == "-5836472")
        #expect(fs.format(1_234.25) == "1234.25")
        #expect(fs.format(nfr(1_234, 56_789)) == "1234/56789")
    }
}
