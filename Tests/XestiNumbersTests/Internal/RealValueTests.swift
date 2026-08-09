// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct RealValueTests {
}

// MARK: -

extension RealValueTests {
    @Test
    func exactInteger() {
        let value = Real(.exactInteger(ei(42)))

        #expect(value.isExact)
        #expect(value.isEqual(to: rei(42)))
    }

    @Test
    func floatingPoint() {
        let value = Real(.floatingPoint(fp(3.14)))

        #expect(value.isInexact)
        #expect(value.isEqual(to: rfp(3.14)))
    }

    @Test
    func fraction() {
        let value = Real(.fraction(fr(3, 4)))

        #expect(value.isExact)
        #expect(value.isEqual(to: rfr(3, 4)))
    }
}
