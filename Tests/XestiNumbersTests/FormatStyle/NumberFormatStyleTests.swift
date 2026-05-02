// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberFormatStyleTests {
}

// MARK: -

extension NumberFormatStyleTests {
    @Test
    func test_format_complex() {
        let fs = Number.FormatStyle().decimalPrecision(1...3)

        #expect(fs.format(ncx(123, 4_567)) == "123+4,567i")
        #expect(fs.format(ncx(123.0, 4_567)) == "123.0+4,567.0i")
        #expect(fs.format(ncx(1_234, 0)) == "1,234+0i")
        #expect(fs.format(ncx(1_234, -1)) == "1,234-1i")
    }

    @Test
    func test_format_exactInteger() {
        let fs = Number.FormatStyle()

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
    func test_format_floatingPoint() {
        let fs = Number.FormatStyle().decimalPrecision(1...3)

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
    func test_format_fraction_decimal() {
        let fs = Number.FormatStyle().decimalPrecision(0...3).fractionDisplay(strategy: .decimal)

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
    func test_format_fraction_default() {
        let fs = Number.FormatStyle() // == .fractionDisplay(strategy: .simple(alwaysShowDenominator: true))

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
    func test_format_fraction_mixed_default() {
        let fs = Number.FormatStyle().fractionDisplay(strategy: .mixed())   // == .mixed(alwaysShowInteger: false)

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
    func test_format_fraction_mixed_true() {
        let fs = Number.FormatStyle().fractionDisplay(strategy: .mixed(alwaysShowInteger: true))

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
    func test_format_fraction_ratio() {
        let fs = Number.FormatStyle().fractionDisplay(strategy: .ratio)

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
    func test_format_fraction_simple_false() {
        let fs = Number.FormatStyle().fractionDisplay(strategy: .simple(alwaysShowDenominator: false))

        #expect(fs.format(nfr(123, 4_567)) == "123/4,567")
        #expect(fs.format(nfr(1_234, 56_789)) == "1,234/56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012")
        #expect(fs.format(nfr(-583, 6_472)) == "-583/6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890/977")
        #expect(fs.format(nfr(4_012, 9)) == "4,012/9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003")
    }
}
