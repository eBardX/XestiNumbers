// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

private import BigInt
private import XestiTools

extension Number {

    // MARK: Public Nested Types

    /// A format style that converts a number value to its textual representation.
    ///
    /// Instances of ``FormatStyle`` create localized, human-readable text from
    /// ``Number`` values.
    public struct FormatStyle {

        // MARK: Public Initializers

        /// Creates a number format style that uses the provided locale.
        ///
        /// - Parameter locale: The locale to use when formatting numbers.
        ///                     Defaults to `.autoupdatingCurrent`.
        public init(locale: Locale = .autoupdatingCurrent) {
            let range = 1...6

            self.decimalPrecision = range
            self.doubleFormatStyle = FloatingPointFormatStyle<Double>(locale: locale)
                .decimalSeparator(strategy: .always)
                .grouping(.automatic)
                .precision(.fractionLength(range))
                .rounded(rule: .toNearestOrAwayFromZero)
            self.fractionDisplay = .simple()
            self.grouping = true
            self.intFormatStyle = IntegerFormatStyle<Int>(locale: locale)
                .decimalSeparator(strategy: .automatic)
                .grouping(.automatic)
            self.locale = locale
        }

        // MARK: Public Instance Properties

        /// The locale of the format style.
        ///
        /// Use the ``locale(_:)`` modifier to create a copy of this format
        /// style with a different locale.
        public var locale: Locale

        /// An attributed format style based on this number format style.
        public var attributed: Attributed {
            Attributed(baseStyle: self)
        }

        // MARK: Internal Instance Properties

        internal var decimalPrecision: ClosedRange<Int>
        internal var doubleFormatStyle: FloatingPointFormatStyle<Double>
        internal var fractionDisplay: Number.FractionDisplayStrategy
        internal var grouping: Bool
        internal var intFormatStyle: IntegerFormatStyle<Int>
    }
}

// MARK: - FormatStyle

extension Number.FormatStyle: FormatStyle {

    // MARK: Public Instance Methods

    /// Modifies this format style to use the provided decimal precision.
    ///
    /// Use this format style to change the decimal precision used by an
    /// existing number format style.
    ///
    /// - Parameter limit:  The number of digits to use when formatting the part
    ///                     of a number following the decimal separator.
    ///
    /// - Returns:  A number format style modified to use the provided decimal
    ///             precision.
    public func decimalPrecision(_ limit: Int) -> Self {
        decimalPrecision(limit...limit)
    }

    /// Modifies this format style to use the provided decimal precision.
    ///
    /// Use this format style to change the decimal precision used by an
    /// existing number format style.
    ///
    /// - Parameter limits: A range from the minimum to the maximum number of
    ///                     digits to use when formatting the part of a number
    ///                     following the decimal separator.
    ///
    /// - Returns:  A number format style modified to use the provided decimal
    ///             precision.
    public func decimalPrecision(_ limits: ClosedRange<Int>) -> Self {
        let loLimit = clamp(0, limits.lowerBound, 10)
        let hiLimit = clamp(loLimit, limits.upperBound, 10)
        let range = loLimit...hiLimit

        var new = self

        new.decimalPrecision = range
        new.doubleFormatStyle = doubleFormatStyle.precision(.fractionLength(range))

        return new
    }

    /// Formats the provided number, using this style.
    ///
    /// - Parameter value:  The number to format.
    ///
    /// - Returns:  A string representation of the number, formatted according
    ///             to this style.
    public func format(_ value: Number) -> String {
        switch value.value {
        case let .complex(cxValue):
            _formatComplex(cxValue)

        case let .real(reValue):
            _formatReal(reValue)
        }
    }

    /// Modifies this format style to use the provided fraction display strategy.
    ///
    /// Use this format style to change the fraction display strategy used by an
    /// existing number format style.
    ///
    /// - Parameter strategy:   The fraction display strategy to apply to the
    ///                         format style.
    ///
    /// - Returns:  A number format style modified to use the provided fraction
    ///             display strategy.
    public func fractionDisplay(strategy: Number.FractionDisplayStrategy) -> Self {
        var new = self

        new.fractionDisplay = strategy

        return new
    }

    /// Modifies this format style to use the provided grouping behavior.
    ///
    /// Use this format style to change whether grouping separators (such as
    /// thousands separators) are inserted when formatting an exact integer
    /// or floating-point number.
    ///
    /// - Parameter isEnabled:  `true` to show grouping separators; `false`
    ///                         to suppress them. Defaults to `true`.
    ///
    /// - Returns:  A number format style modified to use the provided
    ///             grouping behavior.
    public func grouping(_ isEnabled: Bool = true) -> Self {
        let group: NumberFormatStyleConfiguration.Grouping = isEnabled ? .automatic : .never

        var new = self

        new.doubleFormatStyle = doubleFormatStyle.grouping(group)
        new.grouping = isEnabled
        new.intFormatStyle = intFormatStyle.grouping(group)

        return new
    }

    /// Modifies this format style to use the provided locale.
    ///
    /// Use this format style to change the locale used by an existing number
    /// format style.
    ///
    /// - Parameter locale: The locale to apply to the format style.
    ///
    /// - Returns:  A number format style modified to use the provided locale.
    public func locale(_ locale: Locale) -> Self {
        var new = self

        new.doubleFormatStyle = doubleFormatStyle.locale(locale)
        new.intFormatStyle = intFormatStyle.locale(locale)
        new.locale = locale

        return new
    }

    // MARK: Internal Type Properties

    internal static let fractionSeparator: Character = "/"  // should use "⁄" (U+2044)
    internal static let imaginaryUnit: Character     = "i"
    internal static let minusSign: Character         = "-"  // should use "−" (U+2212)
    internal static let mixedSeparator: Character    = " "
    internal static let plusSign: Character          = "+"
    internal static let ratioSeparator: Character    = ":"

    // MARK: Private Instance Methods

    private func _formatComplex(_ value: Complex) -> String {
        var result = _formatReal(value.realPart)

        if !value.imaginaryPart.isNegative {
            result += String(Self.plusSign)
        }

        result += _formatReal(value.imaginaryPart)
        result += String(Self.imaginaryUnit)

        return result
    }

    private func _formatExactInteger(_ value: ExactInteger) -> String {
        switch value.value {
        case let .large(lgValue):
            _formatLarge(lgValue)

        case let .small(smValue):
            _formatSmall(smValue)
        }
    }

    private func _formatFloatingPoint(_ value: FloatingPoint) -> String {
        doubleFormatStyle.format(value.doubleValue)
    }

    private func _formatFraction(_ value: Fraction) -> String {
        switch fractionDisplay.format {
        case .decimal:
            _formatFloatingPoint(value.floatingPointValue)

        case .mixed:
            _formatFractionMixed(value)

        case .ratio:
            _formatFractionRatio(value)

        case .simple:
            _formatFractionSimple(value)
        }
    }

    private func _formatFractionMixed(_ value: Fraction) -> String {
        guard !value.isInteger
        else { return _formatExactInteger(value.numerator) }

        var (quo, rem) = value.numerator.quotientAndRemainder(dividingBy: value.denominator)
        var result = ""

        if !fractionDisplay.useAlternate {
            if !quo.isZero {
                result += _formatExactInteger(quo)
                result += String(Self.mixedSeparator)
            }

            if rem.isNegative, !quo.isZero {
                rem = rem.negated()
            }
        } else {
            if quo.isZero, rem.isNegative {
                result += String(Self.minusSign)
            }

            result += _formatExactInteger(quo)
            result += String(Self.mixedSeparator)

            if rem.isNegative {
                rem = rem.negated()
            }
        }

        result += _formatExactInteger(rem)
        result += String(Self.fractionSeparator)
        result += _formatExactInteger(value.denominator)

        return result
    }

    private func _formatFractionRatio(_ value: Fraction) -> String {
        var result = _formatExactInteger(value.numerator)

        result += String(Self.ratioSeparator)
        result += _formatExactInteger(value.denominator)

        return result
    }

    private func _formatFractionSimple(_ value: Fraction) -> String {
        var result = _formatExactInteger(value.numerator)

        if !fractionDisplay.useAlternate || !value.isInteger {
            result += String(Self.fractionSeparator)
            result += _formatExactInteger(value.denominator)
        }

        return result
    }

    private func _formatLarge(_ value: BigInt) -> String {
        let magStr = String(value.magnitude)

        var result = value < 0 ? String(Self.minusSign) : ""

        if let grpSep = _groupingSeparator(), magStr.count > 3 {
            var group = (3 - (magStr.count % 3)) % 3

            for char in magStr {
                if group == 3 {
                    result += grpSep

                    group = 0
                }

                result.append(char)

                group += 1
            }
        } else {
            result += magStr
        }

        return result
    }

    private func _formatReal(_ value: Real) -> String {
        switch value.value {
        case let .exactInteger(eiValue):
            _formatExactInteger(eiValue)

        case let .floatingPoint(fpValue):
            _formatFloatingPoint(fpValue)

        case let .fraction(frValue):
            _formatFraction(frValue)
        }
    }

    private func _formatSmall(_ value: Int) -> String {
        intFormatStyle.format(value)
    }

    private func _groupingSeparator() -> String? {
        guard grouping
        else { return nil }

        // Probe `intFormatStyle` — which already carries the correct
        // automatic/never grouping policy for `locale` — instead of trusting
        // `locale.groupingSeparator`, which can be non-nil even for locales
        // (such as `en_US_POSIX`) whose automatic grouping policy is off.
        let probe = intFormatStyle.format(1_000)

        guard let separator = probe.first(where: { !$0.isNumber })
        else { return nil }

        return String(separator)
    }
}

// MARK: -

extension FormatStyle where Self == Number.FormatStyle {
    /// A style for formatting a number.
    public static var number: Self {
        Self()
    }
}

// MARK: -

extension Number {

    // MARK: Public Instance Methods

    /// Formats the number using the default localized format style.
    ///
    /// - Returns:  A string representation of the number, formatted according
    ///             to the default format style.
    public func formatted() -> String {
        FormatStyle().format(self)
    }

    /// Formats the number using the provided format style.
    ///
    /// - Parameter format: The format style to apply when formatting the
    ///                     number.
    ///
    /// - Returns:  A localized, formatted string representation of the number.
    public func formatted<S: Foundation.FormatStyle>(_ format: S) -> S.FormatOutput where Self == S.FormatInput {
        format.format(self)
    }
}
