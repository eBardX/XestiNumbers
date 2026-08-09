// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

// swiftlint:disable:next type_name
struct AttributeScopesXestiNumbersAttributesFormattedNumberAttributesSeparatorAttributeSeparatorTests {
}

// MARK: -

extension AttributeScopesXestiNumbersAttributesFormattedNumberAttributesSeparatorAttributeSeparatorTests {
    @Test
    func codable() throws {
        typealias Separator = AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute.Separator

        for separator: Separator in [.complex, .decimal, .fraction, .mixed, .ratio] {
            let data = try JSONEncoder().encode(separator)
            let decoded = try JSONDecoder().decode(Separator.self, from: data)

            #expect(decoded == separator)
        }
    }

    @Test
    func rawValue() {
        typealias Separator = AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute.Separator

        #expect(Separator.complex.rawValue == 0)
        #expect(Separator.decimal.rawValue == 1)
        #expect(Separator.fraction.rawValue == 2)
        #expect(Separator.mixed.rawValue == 3)
        #expect(Separator.ratio.rawValue == 4)
    }
}
