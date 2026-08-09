// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiNumbers

struct NumberFractionDisplayStrategyTests {
}

// MARK: -

extension NumberFractionDisplayStrategyTests {
    @Test
    func codable() throws {
        let original = Number.FractionDisplayStrategy.mixed(alwaysShowInteger: true)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Number.FractionDisplayStrategy.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func decimal() {
        let strategy = Number.FractionDisplayStrategy.decimal

        #expect(strategy.format == .decimal)
        #expect(!strategy.useAlternate)
    }

    @Test
    func description() {
        #expect(Number.FractionDisplayStrategy.decimal.description == "decimal")
        #expect(Number.FractionDisplayStrategy.ratio.description == "ratio")
        #expect(Number.FractionDisplayStrategy.mixed().description == "mixed(alwaysShowInteger: false)")
        #expect(Number.FractionDisplayStrategy.mixed(alwaysShowInteger: true).description
                == "mixed(alwaysShowInteger: true)")
        #expect(Number.FractionDisplayStrategy.simple().description == "simple(alwaysShowDenominator: true)")
        #expect(Number.FractionDisplayStrategy.simple(alwaysShowDenominator: false).description
                == "simple(alwaysShowDenominator: false)")
    }

    @Test
    func hashable() {
        let a = Number.FractionDisplayStrategy.decimal
        let b = Number.FractionDisplayStrategy.decimal
        let set: Set<Number.FractionDisplayStrategy> = [a, b]

        #expect(a.hashValue == b.hashValue)
        #expect(set.count == 1)
    }

    @Test
    func mixed() {
        let strategy = Number.FractionDisplayStrategy.mixed()

        #expect(strategy.format == .mixed)
        #expect(!strategy.useAlternate)
    }

    @Test
    func mixed_alwaysShowInteger() {
        let strategy = Number.FractionDisplayStrategy.mixed(alwaysShowInteger: true)

        #expect(strategy.format == .mixed)
        #expect(strategy.useAlternate)
    }

    @Test
    func ratio() {
        let strategy = Number.FractionDisplayStrategy.ratio

        #expect(strategy.format == .ratio)
        #expect(!strategy.useAlternate)
    }

    @Test
    func simple() {
        let strategy = Number.FractionDisplayStrategy.simple()

        #expect(strategy.format == .simple)
        #expect(!strategy.useAlternate)
    }

    @Test
    func simple_alwaysShowDenominator() {
        let strategy = Number.FractionDisplayStrategy.simple(alwaysShowDenominator: false)

        #expect(strategy.format == .simple)
        #expect(strategy.useAlternate)
    }
}
