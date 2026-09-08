// © 2026 John Gary Pusey (see LICENSE.md)

public import Foundation

private import BigInt

extension Number.FormatStyle {

    // MARK: Public Nested Types

    /// A strategy for parsing the textual representation produced by a
    /// ``Number/FormatStyle`` back into a ``Number`` value.
    ///
    /// A parse strategy is tied to the configuration (locale, grouping, and
    /// fraction display strategy) of the ``Number/FormatStyle`` that created
    /// it, so it only recognizes text in the shape that style would have
    /// produced. Use the ``Number/FormatStyle/parseStrategy`` property to
    /// obtain one, rather than constructing it directly.
    ///
    /// - Note:  Because formatting loses some shape information (for
    ///          example, an exact fraction whose value is an integer, such
    ///          as `4/1`, formats identically to a plain integer under some
    ///          fraction display strategies), parsing text without a
    ///          fraction- or complex-specific separator always produces an
    ///          exact integer or floating-point ``Number``, never an exact
    ///          fraction.
    public struct ParseStrategy {

        // MARK: Internal Initializers

        internal init(_ formatStyle: Number.FormatStyle) {
            self.doubleFormatStyle = formatStyle.doubleFormatStyle
            self.fractionDisplay = formatStyle.fractionDisplay
            self.grouping = formatStyle.grouping
            self.intFormatStyle = formatStyle.intFormatStyle
            self.locale = formatStyle.locale
        }

        // MARK: Internal Instance Properties

        internal let doubleFormatStyle: FloatingPointFormatStyle<Double>
        internal let fractionDisplay: Number.FractionDisplayStrategy
        internal let grouping: Bool
        internal let intFormatStyle: IntegerFormatStyle<Int>
        internal let locale: Locale
    }
}

// MARK: - ParseStrategy

extension Number.FormatStyle.ParseStrategy: ParseStrategy {

    // MARK: Public Instance Methods

    /// Parses the provided input string into a number.
    ///
    /// - Parameter value:  The input string to parse.
    ///
    /// - Throws:   ``Number/FormatStyle/ParseError`` if the input string is
    ///             not in the format produced by the associated
    ///             ``Number/FormatStyle``.
    ///
    /// - Returns:  The parsed number.
    public func parse(_ value: String) throws -> Number {
        guard let result = _parseNumber(value)
        else { throw Number.FormatStyle.ParseError(input: value) }

        return result
    }

    // MARK: Private Instance Methods

    private func _decimalSeparator() -> String {
        // `doubleFormatStyle` always shows the decimal separator (it uses
        // `.decimalSeparator(strategy: .always)`), so formatting `0` always
        // exposes it, regardless of the configured precision.
        let probe = doubleFormatStyle.format(0)

        guard let separator = probe.first(where: { !$0.isNumber })
        else { return "." }

        return String(separator)
    }

    private func _groupingSeparator() -> String? {
        guard grouping
        else { return nil }

        // As in `Number.FormatStyle._groupingSeparator()`, probe
        // `intFormatStyle` instead of trusting `locale.groupingSeparator`,
        // which can be non-nil even for locales whose automatic grouping
        // policy is off.
        let probe = intFormatStyle.format(1_000)

        guard let separator = probe.first(where: { !$0.isNumber })
        else { return nil }

        return String(separator)
    }

    private func _looksLikeExactInteger(_ text: some StringProtocol) -> Bool {
        var chars = Substring(text)

        if let first = chars.first,
           first == Number.FormatStyle.minusSign || first == Number.FormatStyle.plusSign {
            chars.removeFirst()
        }

        guard !chars.isEmpty
        else { return false }

        let sep = _groupingSeparator()

        for char in chars {
            if char.isNumber {
                continue
            }

            if let sep,
               String(char) == sep {
                continue
            }

            return false
        }

        return true
    }

    private func _looksLikeFloatingPoint(_ text: String) -> Bool {
        let specials = [doubleFormatStyle.format(.nan),
                        doubleFormatStyle.format(.infinity),
                        doubleFormatStyle.format(-.infinity)]

        if specials.contains(text) {
            return true
        }

        var chars = Substring(text)

        if let first = chars.first,
           first == Number.FormatStyle.minusSign || first == Number.FormatStyle.plusSign {
            chars.removeFirst()
        }

        guard !chars.isEmpty
        else { return false }

        let groupSep = _groupingSeparator()
        let decSep = _decimalSeparator()
        var sawDecimalSeparator = false

        for char in chars {
            if char.isNumber {
                continue
            }

            if let groupSep,
               String(char) == groupSep {
                continue
            }

            if String(char) == decSep {
                guard !sawDecimalSeparator   // at most one decimal separator
                else { return false }

                sawDecimalSeparator = true

                continue
            }

            return false
        }

        // `doubleFormatStyle` always shows the decimal separator (it uses
        // `.decimalSeparator(strategy: .always)`), so a valid floating-point
        // string always contains one.
        return sawDecimalSeparator
    }

    private func _parseComplex(_ input: String) -> Number? {
        let body = input.dropLast()   // drop the trailing "i"

        guard !body.isEmpty
        else { return nil }

        // The imaginary part's sign is always shown explicitly (the format
        // side always emits a leading "+" or "-" ahead of it), so the last
        // sign character in the string — other than a leading sign on the
        // real part itself — marks where the imaginary part begins.
        guard let signIndex = body.indices.dropFirst().last(where: {
            body[$0] == Number.FormatStyle.plusSign || body[$0] == Number.FormatStyle.minusSign
        })
        else { return nil }

        let realText = String(body[body.startIndex..<signIndex])
        let imagText = String(body[signIndex...])

        guard let realPart = _parseReal(realText),
              let imagPart = _parseReal(imagText)
        else { return nil }

        return Number(.complex(Complex(realPart: realPart,
                                       imaginaryPart: imagPart)))
    }

    private func _parseExactInteger(_ text: some StringProtocol) -> ExactInteger? {
        let text = String(text)

        guard _looksLikeExactInteger(text)
        else { return nil }

        if let small = try? intFormatStyle.parseStrategy.parse(text) {
            return ExactInteger(small)
        }

        return _parseLargeExactInteger(text)
    }

    private func _parseFloatingPoint(_ text: String) -> FloatingPoint? {
        // `FloatingPointFormatStyle.ParseStrategy` parses a leading prefix
        // rather than requiring the whole string to match (for example, it
        // happily parses "123/0" as `123`), so the syntax has to be
        // validated first.
        guard _looksLikeFloatingPoint(text),
              let value = try? doubleFormatStyle.parseStrategy.parse(text)
        else { return nil }

        return FloatingPoint(value)
    }

    private func _parseFractionMixed(_ text: String) -> Fraction? {
        if let spaceIndex = text.firstIndex(of: Number.FormatStyle.mixedSeparator) {
            return _parseFractionMixedWithQuotient(text,
                                                   spaceIndex: spaceIndex)
        }

        // A quotient of zero is entirely omitted only when the strategy
        // doesn't always show the integer part; what remains is exactly the
        // "simple fraction" syntax.
        guard !fractionDisplay.useAlternate,
              let sepIndex = text.firstIndex(of: Number.FormatStyle.fractionSeparator)
        else { return nil }

        let remText = text[text.startIndex..<sepIndex]
        let denText = text[text.index(after: sepIndex)...]

        guard let rem = _parseExactInteger(remText),
              let den = _parseExactInteger(denText),
              !den.isNegative, !den.isZero
        else { return nil }

        return Fraction(numerator: rem,
                        denominator: den)
    }

    private func _parseFractionMixedWithQuotient(_ text: String,
                                                 spaceIndex: String.Index) -> Fraction? {
        let quoText = text[text.startIndex..<spaceIndex]
        let rest = text[text.index(after: spaceIndex)...]

        guard let sepIndex = rest.firstIndex(of: Number.FormatStyle.fractionSeparator)
        else { return nil }

        let remText = rest[rest.startIndex..<sepIndex]
        let denText = rest[rest.index(after: sepIndex)...]

        // "-0" is a quotient of zero paired with a negative remainder — a
        // shape `ExactInteger` cannot represent directly (there's no
        // negative zero), so it has to be recognized specially.
        let isNegativeZero = quoText == "\(Number.FormatStyle.minusSign)0"
        let quoValue: ExactInteger? = isNegativeZero ? .zero : _parseExactInteger(quoText)

        guard let quo = quoValue,
              let rem = _parseExactInteger(remText),
              let den = _parseExactInteger(denText),
              !rem.isNegative, !den.isNegative, !den.isZero
        else { return nil }

        let isNegative = isNegativeZero || quo.isNegative
        let quoMagnitude = quo.isNegative ? quo.negated() : quo
        var numerator = quoMagnitude.multiplied(by: den).adding(rem)

        if isNegative {
            numerator = numerator.negated()
        }

        return Fraction(numerator: numerator,
                        denominator: den)
    }

    private func _parseFractionRatio(_ text: String) -> Fraction? {
        guard let sepIndex = text.firstIndex(of: Number.FormatStyle.ratioSeparator)
        else { return nil }

        let numText = text[text.startIndex..<sepIndex]
        let denText = text[text.index(after: sepIndex)...]

        guard let num = _parseExactInteger(numText),
              let den = _parseExactInteger(denText),
              !den.isNegative, !den.isZero
        else { return nil }

        return Fraction(numerator: num,
                        denominator: den)
    }

    private func _parseFractionSimple(_ text: String) -> Fraction? {
        guard let sepIndex = text.firstIndex(of: Number.FormatStyle.fractionSeparator) else {
            // No separator: only valid Fraction syntax when the strategy
            // allows the denominator to be omitted for integer values.
            guard fractionDisplay.useAlternate,
                  let num = _parseExactInteger(text)
            else { return nil }

            return Fraction(numerator: num,
                            denominator: .one)
        }

        let numText = text[text.startIndex..<sepIndex]
        let denText = text[text.index(after: sepIndex)...]

        guard let num = _parseExactInteger(numText),
              let den = _parseExactInteger(denText),
              !den.isNegative, !den.isZero
        else { return nil }

        return Fraction(numerator: num,
                        denominator: den)
    }

    private func _parseLargeExactInteger(_ text: String) -> ExactInteger? {
        var text = text
        var isNegative = false

        if text.first == Number.FormatStyle.minusSign {
            isNegative = true
            text.removeFirst()
        } else if text.first == Number.FormatStyle.plusSign {
            text.removeFirst()
        }

        if let sep = _groupingSeparator() {
            text = text.replacing(sep, with: "")
        }

        guard !text.isEmpty,
              text.allSatisfy(\.isNumber),
              var value = BigInt(text, radix: 10)
        else { return nil }

        if isNegative {
            value = -value
        }

        return ExactInteger(value)
    }

    private func _parseNumber(_ input: String) -> Number? {
        guard !input.isEmpty
        else { return nil }

        if input.hasSuffix(String(Number.FormatStyle.imaginaryUnit)) {
            return _parseComplex(input)
        }

        guard let realValue = _parseReal(input)
        else { return nil }

        return Number(.real(realValue))
    }

    private func _parseReal(_ text: String) -> Real? {
        switch fractionDisplay.format {
        case .decimal:
            break   // never emitted in fraction syntax; fall through below

        case .mixed:
            if let fraction = _parseFractionMixed(text) {
                return Real(.fraction(fraction))
            }

        case .ratio:
            if let fraction = _parseFractionRatio(text) {
                return Real(.fraction(fraction))
            }

        case .simple:
            if let fraction = _parseFractionSimple(text) {
                return Real(.fraction(fraction))
            }
        }

        return _parseRealNumber(text)
    }

    private func _parseRealNumber(_ text: String) -> Real? {
        if let intVal = _parseExactInteger(text) {
            return Real(.exactInteger(intVal))
        }

        if let fpVal = _parseFloatingPoint(text) {
            return Real(.floatingPoint(fpVal))
        }

        return nil
    }
}

// MARK: - Codable

extension Number.FormatStyle.ParseStrategy: Codable {
}

// MARK: - Hashable

extension Number.FormatStyle.ParseStrategy: Hashable {
}

// MARK: -

extension Number.FormatStyle {

    // MARK: Public Instance Properties

    /// The parse strategy associated with this format style.
    ///
    /// Use this parse strategy to convert text produced by this format
    /// style back into a ``Number`` value.
    public var parseStrategy: ParseStrategy {
        ParseStrategy(self)
    }
}

// MARK: - ParseableFormatStyle

extension Number.FormatStyle: ParseableFormatStyle {
}
