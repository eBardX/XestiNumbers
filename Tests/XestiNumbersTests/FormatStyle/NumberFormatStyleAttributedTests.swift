// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberFormatStyleAttributedTests {
}

// MARK: -

extension NumberFormatStyleAttributedTests {
    @Test
    func test_format_complex() {
        let fs = Number.FormatStyle().decimalPrecision(1...3).attributed

        #expect(fs.format(ncx(123, 4_567)) ==
                "123" +
                mas("+", AttributeContainer.separator(.complex)) +
                "4,567i")
        #expect(fs.format(ncx(-123, 4_567)) ==
                "-123" +
                mas("+", AttributeContainer.separator(.complex)) +
                "4,567i")
        #expect(fs.format(ncx(123.0, 4_567)) ==
                "123" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "0" +
                mas("+", AttributeContainer.separator(.complex)) +
                "4,567" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "0i")
        #expect(fs.format(ncx(-123.0, 4_567)) ==
                "-123" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "0" +
                mas("+", AttributeContainer.separator(.complex)) +
                "4,567" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "0i")
        #expect(fs.format(ncx(1_234, 0)) ==
                "1,234" +
                mas("+", AttributeContainer.separator(.complex)) +
                "0i")
        #expect(fs.format(ncx(1_234, -1)) ==
                "1,234" +
                mas("-", AttributeContainer.separator(.complex)) +
                "1i")
    }

    @Test
    func test_format_exactInteger() {
        let fs = Number.FormatStyle().attributed

        #expect(fs.format(123) == "123")
        #expect(fs.format(1_234) == "1,234")
        #expect(fs.format(5_836_472) == "5,836,472")
        #expect(fs.format(-5_836_472) == "-5,836,472")
        #expect(fs.format("12345678901234567890123456789012345678901234567890") ==
                "12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890") ==
                "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890")
    }

    @Test
    func test_format_floatingPoint() {
        let fs = Number.FormatStyle().decimalPrecision(1...3).attributed

        #expect(fs.format(123.0) ==
                "123" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "0")
        #expect(fs.format(1_234.25) ==
                "1,234" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "25")
        #expect(fs.format(5_836_472.375) ==
                "5,836,472" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "375")
        #expect(fs.format(-5_836_472.6125) ==
                "-5,836,472" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "613")
        #expect(fs.format(.pi) ==
                "3" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "142")
        #expect(fs.format(.nan) == "NaN")
        #expect(fs.format(.positiveInfinity) == "∞")
        #expect(fs.format(.negativeInfinity) == "-∞")
    }

    @Test
    func test_format_fraction_decimal() {
        let fs = Number.FormatStyle().decimalPrecision(0...3).fractionDisplay(strategy: .decimal).attributed

        #expect(fs.format(nfr(123, 4_567)) ==
                "0" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "027")
        #expect(fs.format(nfr(1_234, 56_789)) ==
                "0" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "022")
        #expect(fs.format(nfr(4_012, 1)) ==
                "4,012" +
                mas(".", AttributeContainer.separator(.decimal)))
        #expect(fs.format(nfr(-583, 6_472)) ==
                "-0" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "09")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,636,314,126,135,689,000,000,000,000,000,000,000,000,000,000" +
                mas(".", AttributeContainer.separator(.decimal)))
        #expect(fs.format(nfr(4_012, 9)) ==
                "445" +
                mas(".", AttributeContainer.separator(.decimal)) +
                "778")
        #expect(fs.format(nfr(4_012, 4)) ==
                "1,003" +
                mas(".", AttributeContainer.separator(.decimal)))
    }

    @Test
    func test_format_fraction_default() {
        let fs = Number.FormatStyle().attributed    // == .fractionDisplay(strategy: .simple(alwaysShowDenominator: true))

        #expect(fs.format(nfr(123, 4_567)) ==
                "123" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "4,567")
        #expect(fs.format(nfr(1_234, 56_789)) ==
                "1,234" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "56,789")
        #expect(fs.format(nfr(4_012, 1)) ==
                "4,012" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "1")
        #expect(fs.format(nfr(-583, 6_472)) ==
                "-583" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "977")
        #expect(fs.format(nfr(4_012, 9)) ==
                "4,012" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "9")
        #expect(fs.format(nfr(4_012, 4)) ==
                "1,003" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "1")
    }

    @Test
    func test_format_fraction_mixed_default() {
        let fs = Number.FormatStyle().fractionDisplay(strategy: .mixed()).attributed    // == .mixed(alwaysShowInteger: false)

        #expect(fs.format(nfr(123, 4_567)) ==
                "123" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "4,567")
        #expect(fs.format(nfr(1_234, 56_789)) ==
                "1,234" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012")
        #expect(fs.format(nfr(-583, 6_472)) ==
                "-583" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,636,314,126,135,688,730,934,960,889,470,159,343,808,837,838" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "164" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "977")
        #expect(fs.format(nfr(4_012, 9)) ==
                "445" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "7" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "9")
        #expect(fs.format(nfr(-4_012, 9)) ==
                "-445" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "7" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003")
        #expect(fs.format(nfr(0, 1)) == "0")
    }

    @Test
    func test_format_fraction_mixed_true() {
        let fs = Number.FormatStyle().fractionDisplay(strategy: .mixed(alwaysShowInteger: true)).attributed

        #expect(fs.format(nfr(123, 4_567)) ==
                "0" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "123" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "4,567")
        #expect(fs.format(nfr(1_234, 56_789)) ==
                "0" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "1,234" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012")
        #expect(fs.format(nfr(-583, 6_472)) ==
                "-0" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "583" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,636,314,126,135,688,730,934,960,889,470,159,343,808,837,838" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "164" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "977")
        #expect(fs.format(nfr(4_012, 9)) ==
                "445" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "7" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "9")
        #expect(fs.format(nfr(-4_012, 9)) ==
                "-445" +
                mas(" ", AttributeContainer.separator(.mixed)) +
                "7" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003")
        #expect(fs.format(nfr(0, 1)) == "0")
    }

    @Test
    func test_format_fraction_ratio() {
        let fs = Number.FormatStyle().fractionDisplay(strategy: .ratio).attributed

        #expect(fs.format(nfr(123, 4_567)) ==
                "123" +
                mas(":", AttributeContainer.separator(.ratio)) +
                "4,567")
        #expect(fs.format(nfr(1_234, 56_789)) ==
                "1,234" +
                mas(":", AttributeContainer.separator(.ratio)) +
                "56,789")
        #expect(fs.format(nfr(4_012, 1)) ==
                "4,012" +
                mas(":", AttributeContainer.separator(.ratio)) +
                "1")
        #expect(fs.format(nfr(-583, 6_472)) ==
                "-583" +
                mas(":", AttributeContainer.separator(.ratio)) +
                "6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890" +
                mas(":", AttributeContainer.separator(.ratio)) +
                "977")
        #expect(fs.format(nfr(4_012, 9)) ==
                "4,012" +
                mas(":", AttributeContainer.separator(.ratio)) +
                "9")
        #expect(fs.format(nfr(4_012, 4)) ==
                "1,003" +
                mas(":", AttributeContainer.separator(.ratio)) +
                "1")
    }

    @Test
    func test_format_fraction_simple_false() {
        let fs = Number.FormatStyle().fractionDisplay(strategy: .simple(alwaysShowDenominator: false)).attributed

        #expect(fs.format(nfr(123, 4_567)) ==
                "123" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "4,567")
        #expect(fs.format(nfr(1_234, 56_789)) ==
                "1,234" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "56,789")
        #expect(fs.format(nfr(4_012, 1)) == "4,012")
        #expect(fs.format(nfr(-583, 6_472)) ==
                "-583" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "6,472")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890/977") ==
                "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "977")
        #expect(fs.format(nfr(4_012, 9)) ==
                "4,012" +
                mas("/", AttributeContainer.separator(.fraction)) +
                "9")
        #expect(fs.format(nfr(4_012, 4)) == "1,003")
    }
}
