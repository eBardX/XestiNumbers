// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Internal Nested Types

    internal enum Radix: Int {
        case binary      = 2
        case decimal     = 10
        case hexadecimal = 16
        case octal       = 8
    }
}

// MARK: - Sendable

extension Number.Radix: Sendable {
}
