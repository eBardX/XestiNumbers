// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

private import BigInt

extension Number.FormatStyle {

    // MARK: Public Nested Types

    /// A format style that converts a number value to an attributed string.
    ///
    /// Use the ``attributed`` modifier on a ``Number/FormatStyle`` instance to
    /// create a format style of this type.
    public struct Attributed {

        // MARK: Internal Initializers

        internal init(baseStyle: Number.FormatStyle) {
            self.baseStyle = baseStyle
        }

        // MARK: Private Instance Properties

        private let baseStyle: Number.FormatStyle
    }
}

// MARK: - FormatStyle

extension Number.FormatStyle.Attributed: FormatStyle {

    // MARK: Public Instance Methods

    /// Formats the provided number, using this style.
    ///
    /// - Parameter value:  The number to format.
    ///
    /// - Returns:  An attributed string representation of the number, formatted
    ///             according to this style. The returned string contains
    ///             attributes from the
    ///             `AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes`
    ///             attribute scope to indicate runs formatted by this format
    ///             style.
    public func format(_ value: Number) -> AttributedString {
        switch value.value {
        case let .complex(cxValue):
            _attributedFormatComplex(cxValue)

        case let .real(reValue):
            _attributedFormatReal(reValue)
        }
    }

    // MARK: Private Instance Methods

    private func _attributedFormatComplex(_ value: Complex) -> AttributedString {
        var result = _attributedFormatReal(value.realPart)

        let ivalue = value.imaginaryPart

        result += AttributedString(String(ivalue.isNegative
                                          ? Number.FormatStyle.minusSign
                                          : Number.FormatStyle.plusSign),
                                   attributes: AttributeContainer.separator(.complex))

        result += _attributedFormatReal(ivalue.absoluteValue())

        result += AttributedString(String(Number.FormatStyle.imaginaryUnit))

        return result
    }

    private func _attributedFormatExactInteger(_ value: ExactInteger) -> AttributedString {
        switch value.value {
        case let .large(lgValue):
            _attributedFormatLarge(lgValue)

        case let .small(smValue):
            _attributedFormatSmall(smValue)
        }
    }

    private func _attributedFormatFloatingPoint(_ value: FloatingPoint) -> AttributedString {
        var result = baseStyle.doubleFormatStyle.attributed.format(value.doubleValue)

        result.numberPart = nil

        result.replaceAttributes(AttributeContainer.numberSymbol(.decimalSeparator),
                                 with: AttributeContainer.separator(.decimal))

        result.replaceAttributes(AttributeContainer.numberSymbol(.groupingSeparator),
                                 with: AttributeContainer())

        result.replaceAttributes(AttributeContainer.numberSymbol(.sign),
                                 with: AttributeContainer())

        return result
    }

    private func _attributedFormatFraction(_ value: Fraction) -> AttributedString {
        switch baseStyle.fractionDisplay.format {
        case .decimal:
            _attributedFormatFloatingPoint(value.floatingPointValue)

        case .mixed:
            _attributedFormatFractionMixed(value)

        case .ratio:
            _attributedFormatFractionRatio(value)

        case .simple:
            _attributedFormatFractionSimple(value)
        }
    }

    private func _attributedFormatFractionMixed(_ value: Fraction) -> AttributedString {
        guard !value.isInteger
        else { return _attributedFormatExactInteger(value.numerator) }

        var (quo, rem) = value.numerator.quotientAndRemainder(dividingBy: value.denominator)
        var result = AttributedString()

        if !baseStyle.fractionDisplay.useAlternate {
            if !quo.isZero {
                result += _attributedFormatExactInteger(quo)

                result += AttributedString(String(Number.FormatStyle.mixedSeparator),
                                           attributes: AttributeContainer.separator(.mixed))
            }

            if rem.isNegative, !quo.isZero {
                rem = rem.negated()
            }
        } else {
            if quo.isZero, rem.isNegative {
                result += AttributedString(String(Number.FormatStyle.minusSign))
            }

            result += _attributedFormatExactInteger(quo)

            result += AttributedString(String(Number.FormatStyle.mixedSeparator),
                                       attributes: AttributeContainer.separator(.mixed))

            if rem.isNegative {
                rem = rem.negated()
            }
        }

        result += _attributedFormatExactInteger(rem)

        result += AttributedString(String(Number.FormatStyle.fractionSeparator),
                                   attributes: AttributeContainer.separator(.fraction))

        result += _attributedFormatExactInteger(value.denominator)

        return result
    }

    private func _attributedFormatFractionRatio(_ value: Fraction) -> AttributedString {
        var result = _attributedFormatExactInteger(value.numerator)

        result += AttributedString(String(Number.FormatStyle.ratioSeparator),
                                   attributes: AttributeContainer.separator(.ratio))

        result += _attributedFormatExactInteger(value.denominator)

        return result
    }

    private func _attributedFormatFractionSimple(_ value: Fraction) -> AttributedString {
        var result = _attributedFormatExactInteger(value.numerator)

        if !baseStyle.fractionDisplay.useAlternate || !value.isInteger {
            result += AttributedString(String(Number.FormatStyle.fractionSeparator),
                                       attributes: AttributeContainer.separator(.fraction))

            result += _attributedFormatExactInteger(value.denominator)
        }

        return result
    }

    private func _attributedFormatLarge(_ value: BigInt) -> AttributedString {
        let magStr = String(value.magnitude)

        var result = (value < 0
                      ? AttributedString(String(Number.FormatStyle.minusSign))
                      : AttributedString())

        if magStr.count > 3 {
            let grpSep = AttributedString(baseStyle.locale.groupingSeparator ?? ",")

            var group = (3 - (magStr.count % 3)) % 3

            for char in magStr {
                if group == 3 {
                    result += grpSep

                    group = 0
                }

                result += AttributedString(String(char))

                group += 1
            }
        } else {
            result += AttributedString(magStr)
        }

        return result
    }

    private func _attributedFormatReal(_ value: Real) -> AttributedString {
        switch value.value {
        case let .exactInteger(eiValue):
            _attributedFormatExactInteger(eiValue)

        case let .floatingPoint(fpValue):
            _attributedFormatFloatingPoint(fpValue)

        case let .fraction(frValue):
            _attributedFormatFraction(frValue)
        }
    }

    private func _attributedFormatSmall(_ value: Int) -> AttributedString {
        var result = baseStyle.intFormatStyle.attributed.format(value)

        result.numberPart = nil
        result.numberSymbol = nil

        return result
    }
}
