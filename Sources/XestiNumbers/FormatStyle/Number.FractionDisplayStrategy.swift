// © 2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Nested Types

    /// A display strategy that ``FormatStyle`` uses to format a number that is
    /// represented internally as an exact fraction.
    public struct FractionDisplayStrategy {

        // mixed(alwaysShowInteger: false):     "2 1/4", "-1 1/3", "1", "1/2", "-1/4"
        // mixed(alwaysShowInteger: true):      "2 1/4", "-1 1/3", "1", "0 1/2", "-0 1/4"
        // ratio:                               "9:4", "−4:3", "1:1"
        // simple(alwaysShowDenominator: false) "-1/2", "17/3", "-5", "2/3", "−3/4", "4/9", "9/4", "−4/3", "1"
        // simple(alwaysShowDenominator: true)  "-1/2", "17/3", "-5/1", "2/3", "−3/4", "4/9", "9/4", "−4/3", "1/1"

        // MARK: Public Type Properties

        /// A display strategy that formats an exact fraction as a decimal
        /// fraction.
        ///
        /// This display strategy behaves as if the exact fraction were
        /// converted to a floating-point value. The decimal precision
        /// configuration of ``Number/FormatStyle`` is applied.
        ///
        /// ```swift
        /// let formatStyle = Number.FormatStyle(locale: Locale("en_US"))
        ///                         .fractionDisplay(strategy: .decimal)
        ///
        /// formatStyle.format(Number(numerator: -5, denominator: 1))    // -5.0
        /// formatStyle.format(Number(numerator: 355, denominator: 113)) // 3.141592
        /// formatStyle.format(Number(numerator: 7, denominator: 8))     // 0.875
        /// ```
        public static var decimal: Self {
            Self(format: .decimal,
                 useAlternate: false)
        }

        /// A display strategy that formats an exact fraction as a ratio.
        ///
        /// This display strategy is similar to
        /// ``simple(alwaysShowDenominator:)``, except it uses a different
        /// separator character between numerator and denominator (“`:`” instead
        /// of “`/`”), and it _always_ shows the denominator.
        ///
        /// ```swift
        /// let formatStyle = Number.FormatStyle(locale: Locale("en_US"))
        ///                         .fractionDisplay(strategy: .ratio)
        ///
        /// formatStyle.format(Number(numerator: -5, denominator: 1))    // -5:1
        /// formatStyle.format(Number(numerator: 355, denominator: 113)) // 355:113
        /// formatStyle.format(Number(numerator: 7, denominator: 8))     // 7:8
        /// ```
        public static var ratio: Self {
            Self(format: .ratio,
                 useAlternate: false)
        }

        // MARK: Public Type Methods

        /// A display strategy that formats an exact fraction as a mixed
        /// number.
        ///
        /// This display strategy formats the exact fraction as the combination
        /// of a nonzero integer and a proper fraction (meaning the numerator
        /// is less than the denominator). The integer and fraction parts are
        /// separated by a space, unless one of the parts is zero. By default, a
        /// zero integer part is suppressed. A zero fraction part is always
        /// suppressed.
        ///
        /// ```swift
        /// let formatStyle = Number.FormatStyle(locale: Locale("en_US"))
        ///                         .fractionDisplay(strategy: .mixed())
        ///
        /// formatStyle.format(Number(numerator: -5, denominator: 1))    // -5
        /// formatStyle.format(Number(numerator: 355, denominator: 113)) // 3 16/113
        /// formatStyle.format(Number(numerator: 7, denominator: 8))     // 7/8
        /// ```
        ///
        /// To always show the integer part, even when it is zero, pass `true`
        /// to ``mixed(alwaysShowInteger:)``.
        ///
        /// ```swift
        /// let formatStyle = Number.FormatStyle(locale: Locale("en_US"))
        ///                         .fractionDisplay(strategy: .mixed(alwaysShowInteger: true))
        ///
        /// formatStyle.format(Number(numerator: -5, denominator: 1))    // -5
        /// formatStyle.format(Number(numerator: 355, denominator: 113)) // 3 16/113
        /// formatStyle.format(Number(numerator: 7, denominator: 8))     // 0 7/8
        /// ```
        ///
        /// - Parameter alwaysShowInteger:  A Boolean value that determines
        ///                                 whether the format style should show
        ///                                 the integer part, even when it is
        ///                                 zero. Defaults to `false`.
        ///
        /// - Returns:  A display strategy to format exact fractions as mixed
        ///             numbers, with the provided behavior for integer
        ///             parts.
        public static func mixed(alwaysShowInteger: Bool = false) -> Self {
            Self(format: .mixed,
                 useAlternate: alwaysShowInteger)
        }

        /// A display strategy that formats an exact fraction as a simple
        /// fraction.
        ///
        /// By default, this display strategy _always_ shows the denominator,
        /// even when the exact fraction is an integer.
        ///
        /// ```swift
        /// let formatStyle = Number.FormatStyle(locale: Locale("en_US"))
        ///                         .fractionDisplay(strategy: .simple())
        ///
        /// formatStyle.format(Number(numerator: -5, denominator: 1))    // -5/1
        /// formatStyle.format(Number(numerator: 355, denominator: 113)) // 355/113
        /// formatStyle.format(Number(numerator: 7, denominator: 8))     // 7/8
        /// ```
        ///
        /// To suppress the denominator when the exact fraction is an integer,
        /// pass `false` to ``simple(alwaysShowDenominator:)``.
        ///
        /// ```swift
        /// let formatStyle = Number.FormatStyle(locale: Locale("en_US"))
        ///                         .fractionDisplay(strategy: .simple(alwaysShowDenominator: false))
        ///
        /// formatStyle.format(Number(numerator: -5, denominator: 1))    // -5
        /// formatStyle.format(Number(numerator: 355, denominator: 113)) // 355/113
        /// formatStyle.format(Number(numerator: 7, denominator: 8))     // 7/8
        /// ```
        ///
        /// - Parameter alwaysShowDenominator:  A Boolean value that determines
        ///                                     whether the format style should
        ///                                     show the denominator, even when
        ///                                     the exact fraction is is an
        ///                                     integer. Defaults to `true`.
        ///
        /// - Returns:  A display strategy to format exact fractions as simple
        ///             fractions, with the provided behavior for integer
        ///             values.
        public static func simple(alwaysShowDenominator: Bool = true) -> Self {
            Self(format: .simple,
                 useAlternate: !alwaysShowDenominator)
        }

        // MARK: Internal Nested Types

        internal enum Format: Codable {
            case decimal
            case mixed
            case ratio
            case simple
        }

        // MARK: Internal Instance Properties

        internal let format: Format
        internal let useAlternate: Bool
    }
}

// MARK: - Codable

extension Number.FractionDisplayStrategy: Codable {
}

// MARK: - CustomStringConvertible

extension Number.FractionDisplayStrategy: CustomStringConvertible {
    public var description: String {
        switch format {
        case .decimal:
            "decimal"

        case .mixed:
            "mixed(alwaysShowInteger: \(useAlternate ? "true" : "false"))"

        case .ratio:
            "ratio"

        case .simple:
            "simple(alwaysShowDenominator: \(useAlternate ? "false" : "true"))"
        }
    }
}

// MARK: - Hashable

extension Number.FractionDisplayStrategy: Hashable {
}
