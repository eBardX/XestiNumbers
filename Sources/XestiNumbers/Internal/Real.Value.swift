// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Real {

    // MARK: Internal Nested Types

    internal enum Value {
        case exactInteger(ExactInteger)
        case floatingPoint(FloatingPoint)
        case fraction(Fraction)
    }
}
