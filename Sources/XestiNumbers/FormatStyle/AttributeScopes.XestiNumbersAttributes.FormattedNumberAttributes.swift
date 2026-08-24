// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension AttributeScopes.XestiNumbersAttributes {

    // MARK: Public Nested Types

    /// An attribute scope for attributes applied to numbers formatted by
    /// ``Number/FormatStyle``.
    public struct FormattedNumberAttributes {
        /// The separator attribute.
        public let separator: SeparatorAttribute
    }
}

// MARK: - AttributeScope

extension AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes: AttributeScope {
}
