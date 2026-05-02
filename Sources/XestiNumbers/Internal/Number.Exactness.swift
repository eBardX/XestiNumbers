// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Internal Nested Types

    internal enum Exactness {
        case exact
        case inexact
        case unspecified
    }
}

// MARK: - Sendable

extension Number.Exactness: Sendable {
}
