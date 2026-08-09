// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberExactnessTests {
}

// MARK: -

extension NumberExactnessTests {
    @Test
    func equality() {
        #expect(Number.Exactness.exact == .exact)
        #expect(Number.Exactness.inexact == .inexact)
        #expect(Number.Exactness.unspecified == .unspecified)
        #expect(Number.Exactness.exact != .inexact)
        #expect(Number.Exactness.exact != .unspecified)
        #expect(Number.Exactness.inexact != .unspecified)
    }

    @Test
    func hashable() {
        let cases: Set<Number.Exactness> = [.exact, .exact, .inexact, .unspecified]

        #expect(cases.count == 3)
    }
}
