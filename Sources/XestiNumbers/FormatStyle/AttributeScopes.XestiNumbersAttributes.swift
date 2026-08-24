// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension AttributeScopes {

    // MARK: Public Nested Types

    /// An attribute scope for attributes defined by the XestiNumbers
    /// framework.
    public struct XestiNumbersAttributes {
        /// The formatted number attribute scope.
        public let formattedNumber: FormattedNumberAttributes
    }
}

// MARK: - AttributeScope

extension AttributeScopes.XestiNumbersAttributes: AttributeScope {
}
