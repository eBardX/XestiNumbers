// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

// swiftlint:disable:next type_name
struct AttributeScopesXestiNumbersAttributesFormattedNumberAttributesTests {
}

// MARK: -

extension AttributeScopesXestiNumbersAttributesFormattedNumberAttributesTests {
    @Test
    func separator() {
        let container = AttributeContainer.separator(.decimal)

        #expect(container.separator == .decimal)
    }
}
