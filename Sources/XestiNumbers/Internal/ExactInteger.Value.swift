// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import BigInt

extension ExactInteger {

    // MARK: Internal Nested Types

    internal enum Value {
        case large(BigInt)
        case small(Int)
    }
}
