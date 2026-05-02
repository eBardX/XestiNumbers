// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Internal Nested Types

    internal enum Value {
        case complex(Complex)
        case real(Real)
    }
}

// MARK: - Sendable

extension Number.Value: Sendable {
}
