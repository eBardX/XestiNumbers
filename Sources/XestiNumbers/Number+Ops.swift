// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Type Methods

    /// Performs a bitwise AND operation on the two provided numbers and returns
    /// the result.
    ///
    /// - Warning:  This operation is only defined for integers. Both operands
    ///             must be integers; applying this operation to non-integers
    ///             will result in a fatal error.
    ///
    /// - Parameter n1: The first number on which to perform the bitwise AND
    ///                 operation.
    /// - Parameter n2: The second number on which to perform the bitwise AND
    ///                 operation.
    ///
    /// - Returns:  The result of the bitwise AND operation.
    public static func & (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.checkInteger().bitwiseAnd(with: n2.checkInteger())))
    }

    /// Performs a bitwise AND operation on the two provided numbers and stores
    /// the result in the left-hand-side variable.
    ///
    /// - Warning:  This operation is only defined for integers. Both operands
    ///             must be integers; applying this operation to non-integers
    ///             will result in a fatal error.
    ///
    /// - Parameter n1: The first number on which to perform the bitwise AND
    ///                 operation.
    /// - Parameter n2: The second number on which to perform the bitwise AND
    ///                 operation.
    public static func &= (n1: inout Self,
                           n2: Self) {
        n1 = n1 & n2
    }

    /// Multiplies the two provided numbers and returns the result.
    ///
    /// - Parameter z1: The first number to multiply.
    /// - Parameter z2: The second number to multiply.
    ///
    /// - Returns:  The result of the multiplication.
    public static func * (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)):
            Self(.complex(val1.multiplied(by: val2)))

        case let (.real(val1), .real(val2)):
            Self(.real(val1.multiplied(by: val2)))

        default:
            Self(.complex(z1.toComplex().multiplied(by: z2.toComplex())))
        }
    }

    /// Multiplies the two provided numbers and stores the result in the
    /// left-hand-side variable.
    ///
    /// - Parameter z1: The first number to multiply.
    /// - Parameter z2: The second number to multiply.
    public static func *= (z1: inout Self,
                           z2: Self) {
        z1 = z1 * z2
    }

    /// Adds the two provided numbers and returns the result.
    ///
    /// - Parameter z1: The first number to add.
    /// - Parameter z2: The second number to add.
    ///
    /// - Returns:  The result of the addition.
    public static func + (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)):
            Self(.complex(val1.adding(val2)))

        case let (.real(val1), .real(val2)):
            Self(.real(val1.adding(val2)))

        default:
            Self(.complex(z1.toComplex().adding(z2.toComplex())))
        }
    }

    /// Adds the two provided numbers and stores the result in the
    /// left-hand-side variable.
    ///
    /// - Parameter z1: The first number to add.
    /// - Parameter z2: The second number to add.
    public static func += (z1: inout Self,
                           z2: Self) {
        z1 = z1 + z2
    }

    /// Negates the provided number and returns the result.
    ///
    /// - Parameter z:  The number to negate.
    ///
    /// - Returns:    The result of the negation.
    public static prefix func - (z: Self) -> Self {
        switch z.value {
        case let .complex(val):
            Self(.complex(val.negated()))

        case let .real(val):
            Self(.real(val.negated()))
        }
    }

    /// Subtracts the second provided number from the first and returns the
    /// result.
    ///
    /// - Parameter z1: The number from which to subtract the other.
    /// - Parameter z2: The number to subtract from the other.
    ///
    /// - Returns:  The result of the subtraction.
    public static func - (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)):
            Self(.complex(val1.subtracting(val2)))

        case let (.real(val1), .real(val2)):
            Self(.real(val1.subtracting(val2)))

        default:
            Self(.complex(z1.toComplex().subtracting(z2.toComplex())))
        }
    }

    /// Subtracts the second provided number from the first and stores the
    /// result in the left-hand-side variable.
    ///
    /// - Parameter z1: The number from which to subtract the other.
    /// - Parameter z2: The number to subtract from the other.
    public static func -= (z1: inout Self,
                           z2: Self) {
        z1 = z1 - z2
    }

    /// Divides the first provided number by the second and returns the result.
    ///
    /// - Warning:  The divisor must not be zero; dividing by zero will result
    ///             in a fatal error.
    ///
    /// - Parameter z1: The number to divide by the other.
    /// - Parameter z2: The number by which to divide the other.
    ///
    /// - Returns:  The result of the division.
    public static func / (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)) where !val2.isZero:
            Self(.complex(val1.divided(by: val2)))

        case let (.complex(val1), .real(val2)) where !val2.isZero:
            Self(.complex(val1.divided(by: z2.toComplex())))

        case let (.real, .complex(val2)) where !val2.isZero:
            Self(.complex(z1.toComplex().divided(by: val2)))

        case let (.real(val1), .real(val2)) where !val2.isZero:
            Self(.real(val1.divided(by: val2)))

        default:
            fatalError("divisor must not be zero")
        }
    }

    /// Divides the first provided number by the second and stores the result in
    /// the left-hand-side variable.
    ///
    /// - Warning:  The divisor must not be zero; dividing by zero will result
    ///             in a fatal error.
    ///
    /// - Parameter z1: The number to divide by the other.
    /// - Parameter z2: The number by which to divide the other.
    public static func /= (z1: inout Self,
                           z2: Self) {
        z1 = z1 / z2
    }

    /// Performs a bitwise OR operation on the two provided numbers and returns
    /// the result.
    ///
    /// - Warning:  This operation is only defined for integers. Both operands
    ///             must be integers; applying this operation to non-integers
    ///             will result in a fatal error.
    ///
    /// - Parameter n1: The first number on which to perform the bitwise OR
    ///                 operation.
    /// - Parameter n2: The second number on which to perform the bitwise OR
    ///                 operation.
    ///
    /// - Returns:  The result of the bitwise OR operation.
    public static func | (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.checkInteger().bitwiseOr(with: n2.checkInteger())))
    }

    /// Performs a bitwise OR operation on the two provided numbers and stores
    /// the result in the left-hand-side variable.
    ///
    /// - Warning:  This operation is only defined for integers. Both operands
    ///             must be integers; applying this operation to non-integers
    ///             will result in a fatal error.
    ///
    /// - Parameter n1: The first number on which to perform the bitwise OR
    ///                 operation.
    /// - Parameter n2: The second number on which to perform the bitwise OR
    ///                 operation.
    public static func |= (n1: inout Self,
                           n2: Self) {
        n1 = n1 | n2
    }

    /// Performs a bitwise XOR operation on the two provided numbers and returns
    /// the result.
    ///
    /// - Warning:  This operation is only defined for integers. Both operands
    ///             must be integers; applying this operation to non-integers
    ///             will result in a fatal error.
    ///
    /// - Parameter n1: The first number on which to perform the bitwise XOR
    ///                 operation.
    /// - Parameter n2: The second number on which to perform the bitwise XOR
    ///                 operation.
    ///
    /// - Returns:  The result of the bitwise XOR operation.
    public static func ^ (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.checkInteger().bitwiseXor(with: n2.checkInteger())))
    }

    /// Performs a bitwise XOR operation on the two provided numbers and stores
    /// the result in the left-hand-side variable.
    ///
    /// - Warning:  This operation is only defined for integers. Both operands
    ///             must be integers; applying this operation to non-integers
    ///             will result in a fatal error.
    ///
    /// - Parameter n1: The first number on which to perform the bitwise XOR
    ///                 operation.
    /// - Parameter n2: The second number on which to perform the bitwise XOR
    ///                 operation.
    public static func ^= (n1: inout Self,
                           n2: Self) {
        n1 = n1 ^ n2
    }

    /// Shifts the provided number to the left by the specified bit count and
    /// returns the result.
    ///
    /// - Warning:  This operation is only defined for integers. The first
    ///             operand must be an integer; applying this operation to a
    ///             non-integer will result in a fatal error.
    ///
    /// - Parameter n:  The number to shift left.
    /// - Parameter k:  The bit count by which to shift left.
    ///
    /// - Returns:  The result of the left shift.
    public static func << (n: Self,
                           k: Int) -> Self {
        Self(.real(n.checkInteger().bitwiseShiftLeft(bits: k)))
    }

    /// Shifts the provided number to the left by the specified bit count and
    /// stores the result in the left-hand-side variable.
    ///
    /// - Warning:  This operation is only defined for integers. The first
    ///             operand must be an integer; applying this operation to a
    ///             non-integer will result in a fatal error.
    ///
    /// - Parameter n:  The number to shift left.
    /// - Parameter k:  The bit count by which to shift left.
    public static func <<= (n: inout Self,
                            k: Int) {
        n = n << k
    }

    /// Shifts the provided number to the right by the specified bit count and
    /// returns the result.
    ///
    /// - Warning:  This operation is only defined for integers. The first
    ///             operand must be an integer; applying this operation to a
    ///             non-integer will result in a fatal error.
    ///
    /// - Parameter n:  The number to shift right.
    /// - Parameter k:  The bit count by which to shift right.
    ///
    /// - Returns:  The result of the right shift.
    public static func >> (n: Self,
                           k: Int) -> Self {
        Self(.real(n.checkInteger().bitwiseShiftRight(bits: k)))
    }

    /// Shifts the provided number to the right by the specified bit count and
    /// stores the result in the left-hand-side variable.
    ///
    /// - Warning:  This operation is only defined for integers. The first
    ///             operand must be an integer; applying this operation to a
    ///             non-integer will result in a fatal error.
    ///
    /// - Parameter n:  The number to shift right.
    /// - Parameter k:  The bit count by which to shift right.
    public static func >>= (n: inout Self,
                            k: Int) {
        n = n >> k
    }

    /// Performs a bitwise NOT operation on the provided number and returns the
    /// result.
    ///
    /// - Warning:  This operation is only defined for integers. The operand
    ///             must be an integer; applying this operation to a non-integer
    ///             will result in a fatal error.
    ///
    /// - Parameter n:  The number on which to perform the bitwise NOT
    ///                 operation.
    ///
    /// - Returns:  The result of the bitwise NOT operation.
    public static prefix func ~ (n: Self) -> Self {
        Self(.real(n.checkInteger().bitwiseNot()))
    }
}
