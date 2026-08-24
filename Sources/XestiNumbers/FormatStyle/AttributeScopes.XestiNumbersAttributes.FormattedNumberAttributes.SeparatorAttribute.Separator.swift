// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute {

    // MARK: Public Type Aliases

    /// The type of value associated with this attribute.
    public typealias Value = Separator

    // MARK: Public Nested Types

    /// A kind of separator character in a number formatted by
    /// ``Number/FormatStyle``.
    public enum Separator: Int {
        /// The separator between the real and imaginary parts of a formatted
        /// complex number.
        case complex

        /// The decimal separator in a formatted floating-point number.
        case decimal

        /// The separator between the numerator and denominator of a formatted
        /// fraction.
        case fraction

        /// The separator between the integer and fraction parts of a
        /// formatted mixed number.
        case mixed

        /// The separator between the numerator and denominator of a formatted
        /// ratio.
        case ratio
    }
}

// MARK: - Codable

extension AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute.Separator: Codable {
}

// MARK: - Sendable

extension AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute.Separator: Sendable {
}
