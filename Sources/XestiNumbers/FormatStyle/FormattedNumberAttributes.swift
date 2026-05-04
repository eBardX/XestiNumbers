// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension AttributeDynamicLookup {
    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiNumbersAttributes, T>) -> T {
        self[T.self]
    }

    // swiftlint:disable:next line_length
    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes, T>) -> T {
        self[T.self]
    }
}

// MARK: -

extension AttributeScopes {
    public struct XestiNumbersAttributes: AttributeScope {
        public let formattedNumber: FormattedNumberAttributes
    }
}

// MARK: -

extension AttributeScopes.XestiNumbersAttributes {
    public struct FormattedNumberAttributes: AttributeScope {
        public let separator: SeparatorAttribute
    }
}

// MARK: -

extension AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes {
    public enum SeparatorAttribute: CodableAttributedStringKey {
        public static let name = "XestiNumbers.Separator"
    }
}

// MARK: -

extension AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute {
    public enum Separator: Int, Codable {
        case complex
        case decimal
        case fraction
        case mixed
        case ratio
    }

    public typealias Value = Separator
}

// MARK: - Sendable (AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute.Separator)

extension AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute.Separator: Sendable {
}
