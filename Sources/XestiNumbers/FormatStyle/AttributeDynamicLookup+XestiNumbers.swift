// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension AttributeDynamicLookup {

    // MARK: Public Instance Subscripts

    /// Looks up the attribute at the given key path in the
    /// ``AttributeScopes/XestiNumbersAttributes`` scope.
    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiNumbersAttributes, T>) -> T {
        self[T.self]
    }

    /// Looks up the attribute at the given key path in the
    /// ``AttributeScopes/XestiNumbersAttributes/FormattedNumberAttributes``
    /// scope.
    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes, T>) -> T { // swiftlint:disable:this line_length
        self[T.self]
    }
}
