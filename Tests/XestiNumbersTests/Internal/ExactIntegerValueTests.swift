// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct ExactIntegerValueTests {
}

// MARK: -

extension ExactIntegerValueTests {
    @Test
    func large() {
        let value = ExactInteger(UInt64.max)

        #expect(String(reflecting: value).hasPrefix("large<"))
    }

    @Test
    func small() {
        let value = ExactInteger(42)

        #expect(String(reflecting: value) == "small<42>")
    }
}
