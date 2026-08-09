// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

// swiftlint:disable:next type_name
struct AttributeScopesXestiNumbersAttributesTests {
}

// MARK: -

extension AttributeScopesXestiNumbersAttributesTests {
    @Test
    func formattedNumber() {
        // The `formattedNumber` scope nests `SeparatorAttribute` two levels
        // below `XestiNumbersAttributes`. Composing this key path proves the
        // scope's declared property type lines up with
        // `FormattedNumberAttributes`, which is what makes that nested
        // access possible.
        let keyPath = \AttributeScopes.XestiNumbersAttributes.formattedNumber.separator

        #expect(keyPath == \AttributeScopes.XestiNumbersAttributes.formattedNumber.separator)
    }
}
