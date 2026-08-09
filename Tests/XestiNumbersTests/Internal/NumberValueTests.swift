// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberValueTests {
}

// MARK: -

extension NumberValueTests {
    @Test
    func complex() {
        let value = Number.Value.complex(cx(3, 4))

        guard case let .complex(extracted) = value
        else { Issue.record("expected .complex case"); return }

        #expect(extracted.testEqual(to: cx(3, 4)))
    }

    @Test
    func real() {
        let value = Number.Value.real(rei(42))

        guard case let .real(extracted) = value
        else { Issue.record("expected .real case"); return }

        #expect(extracted.isEqual(to: rei(42)))
    }
}
