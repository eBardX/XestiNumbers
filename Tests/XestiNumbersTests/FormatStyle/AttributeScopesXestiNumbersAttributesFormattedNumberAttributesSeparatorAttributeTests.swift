// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

// swiftlint:disable:next type_name
struct AttributeScopesXestiNumbersAttributesFormattedNumberAttributesSeparatorAttributeTests {
}

// MARK: -

extension AttributeScopesXestiNumbersAttributesFormattedNumberAttributesSeparatorAttributeTests {
    @Test
    func name() {
        #expect(AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes.SeparatorAttribute.name
                == "XestiNumbers.Separator")
    }

    @Test
    func separatorAttribute() {
        let container = AttributeContainer.separator(.decimal)
        let str = AttributedString(".", attributes: container)

        #expect(str.runs.first?.separator == .decimal)
    }
}
