// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberFractionDisplayStrategyFormatTests {
}

// MARK: -

extension NumberFractionDisplayStrategyFormatTests {
    @Test
    func codable() throws {
        for format: Number.FractionDisplayStrategy.Format in [.decimal, .mixed, .ratio, .simple] {
            let data = try JSONEncoder().encode(format)
            let decoded = try JSONDecoder().decode(Number.FractionDisplayStrategy.Format.self, from: data)

            #expect(decoded == format)
        }
    }
}
