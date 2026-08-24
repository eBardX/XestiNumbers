// © 2026 John Gary Pusey (see LICENSE.md)

extension Number.FractionDisplayStrategy {

    // MARK: Internal Nested Types

    internal enum Format {
        case decimal
        case mixed
        case ratio
        case simple
    }
}

// MARK: - Codable

extension Number.FractionDisplayStrategy.Format: Codable {
}
