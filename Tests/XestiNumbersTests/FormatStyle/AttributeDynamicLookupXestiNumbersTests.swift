// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct AttributeDynamicLookupXestiNumbersTests {
}

// MARK: -

extension AttributeDynamicLookupXestiNumbersTests {
    @Test
    func separator() {
        let container = AttributeContainer.separator(.decimal)

        #expect(container.separator == .decimal)
    }
}
