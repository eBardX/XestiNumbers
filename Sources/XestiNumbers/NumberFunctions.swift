// © 2025–2026 John Gary Pusey (see LICENSE.md)

// MARK: - Public Functions

/// Calculates the absolute value of the provided number and returns the result.
///
/// - Warning:  This operation is only defined for real numbers. The operand
///             must be a real number; applying this operation to a complex
///             number with a nonzero imaginary part will result in a fatal
///             error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (abs x) ; R5RS and R7RS
/// ```
///
/// - Parameter x:  The number for which to calculate the absolute value.
///
/// - Returns:  The result of the absolute value calculation.
public func abs(_ x: Number) -> Number {
    Number(.real(x.checkReal().absoluteValue()))
}

/// Calculates the inverse cosine of the provided number and returns the result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (acos z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the inverse cosine.
///
/// - Returns:  The result of the inverse cosine calculation.
public func acos(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseCosine()))

    case let .real(val):
        Number(.real(val.inverseCosine()))
    }
}

/// Calculates the inverse hyperbolic cosine of the provided number and returns
/// the result.
///
/// - Parameter z:  The number for which to calculate the inverse hyperbolic
///                 cosine.
///
/// - Returns:  The result of the inverse hyperbolic cosine calculation.
public func acosh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseHyperbolicCosine()))

    case let .real(val):
        Number(.real(val.inverseHyperbolicCosine()))
    }
}

/// Calculates the inverse sine of the provided number and returns the result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (asin z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the inverse sine.
///
/// - Returns:  The result of the inverse sine calculation.
public func asin(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseSine()))

    case let .real(val):
        Number(.real(val.inverseSine()))
    }
}

/// Calculates the inverse hyperbolic sine of the provided number and returns
/// the result.
///
/// - Parameter z:  The number for which to calculate the inverse hyperbolic
///                 sine.
///
/// - Returns:  The result of the inverse hyperbolic sine calculation.
public func asinh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseHyperbolicSine()))

    case let .real(val):
        Number(.real(val.inverseHyperbolicSine()))
    }
}

/// Calculates the inverse tangent of the provided number and returns the
/// result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (atan z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the inverse tangent.
///
/// - Returns:  The result of the inverse tangent calculation.
public func atan(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseTangent()))

    case let .real(val):
        Number(.real(val.inverseTangent()))
    }
}

/// Calculates the inverse tangent of the two provided numbers and returns the
/// result.
///
/// - Warning:  This operation is only defined for real numbers. Both operands
///             must be real numbers; applying this operation to complex numbers
///             with a nonzero imaginary part will result in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (atan y x) ; R5RS and R7RS
/// ```
///
/// - Parameter y:  The first number for which to calculate the inverse tangent.
/// - Parameter x:  The second number for which to calculate the inverse
///                 tangent.
///
/// - Returns:  The result of the inverse tangent calculation.
public func atan(_ y: Number,
                 _ x: Number) -> Number {
    Number(.real(y.checkReal().inverseTangent(x.checkReal())))
}

/// Calculates the inverse hyperbolic tangent of the provided number and returns
/// the result.
///
/// - Parameter z:  The number for which to calculate the inverse hyperbolic
///                 tangent.
///
/// - Returns:  The result of the inverse hyperbolic tangent calculation.
public func atanh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseHyperbolicTangent()))

    case let .real(val):
        Number(.real(val.inverseHyperbolicTangent()))
    }
}

/// Determines the smallest integer not smaller than the provided number and
/// returns the result.
///
/// If the provided number is inexact, then the result will also be inexact. If
/// the provided number is infinite or a NaN, then it is returned as is.
///
/// - Warning:  This operation is only defined for real numbers. The operand
///             must be a real number; applying this operation to a complex
///             number with a nonzero imaginary part will result in a fatal
///             error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (ceiling x) ; R5RS and R7RS
/// ```
///
/// - Parameter x:  The number for which to determine the ceiling.
///
/// - Returns:  The result of the ceiling determination.
public func ceiling(_ x: Number) -> Number {
    Number(.real(x.checkReal().ceiling()))
}

/// Calculates the cosine of the provided number and returns the result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (cos z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the cosine.
///
/// - Returns:  The result of the cosine calculation.
public func cos(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.cosine()))

    case let .real(val):
        Number(.real(val.cosine()))
    }
}

/// Calculates the hyperbolic cosine of the provided number and returns the
/// result.
///
/// - Parameter z:  The number for which to calculate the hyperbolic cosine.
///
/// - Returns:  The result of the hyperbolic cosine calculation.
public func cosh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.hyperbolicCosine()))

    case let .real(val):
        Number(.real(val.hyperbolicCosine()))
    }
}

/// Calculates the natural exponential of the provided number and returns the
/// result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (exp z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the exponential.
///
/// - Returns:  The result of the exponential calculation.
public func exp(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.exponential()))

    case let .real(val):
        Number(.real(val.exponential()))
    }
}

/// Calculates the exponential of the provided number for the specified base and
/// returns the result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (expt base z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:      The number for which to calculate the exponential.
/// - Parameter base:   The base of the exponential to calculate.
///
/// - Returns:  The result of the exponential calculation.
public func exp(_ z: Number,
                base: Number) -> Number {
    switch (z.value, base.value) {
    case let (.complex(val1), .complex(val2)):
        Number(.complex(val1.exponential(base: val2)))

    case let (.real(val1), .real(val2)):
        Number(.real(val1.exponential(base: val2)))

    default:
        Number(.complex(z.toComplex().exponential(base: base.toComplex())))
    }
}

/// Calculates the base-10 exponential of the provided number and returns the
/// result.
///
/// - Parameter z:  The number for which to calculate the exponential.
///
/// - Returns:  The result of the exponential calculation.
public func exp10(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.exponentialBase10()))

    case let .real(val):
        Number(.real(val.exponentialBase10()))
    }
}

/// Calculates the base-2 exponential of the provided number and returns the
/// result.
///
/// - Parameter z:  The number for which to calculate the exponential.
///
/// - Returns:  The result of the exponential calculation.
public func exp2(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.exponentialBase2()))

    case let .real(val):
        Number(.real(val.exponentialBase2()))
    }
}

/// Determines the largest integer not larger than the provided number and
/// returns the result.
///
/// If the provided number is inexact, then the result will also be inexact. If
/// the provided number is infinite or a NaN, then it is returned as is.
///
/// - Warning:  This operation is only defined for real numbers. The operand
///             must be a real number; applying this operation to a complex
///             number with a nonzero imaginary part will result in a fatal
///             error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (floor x) ; R5RS and R7RS
/// ```
///
/// - Parameter x:  The number for which to determine the floor.
///
/// - Returns:  The result of the floor determination.
public func floor(_ x: Number) -> Number {
    Number(.real(x.checkReal().floor()))
}

/// Calculates the greatest common divisor of the two provided numbers and
/// returns the result.
///
/// - Warning:  This operation is only defined for integers. Both operands must
///             be integers; applying this operation to non-integers will result
///             in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (gcd n1 n2) ; R5RS and R7RS
/// ```
///
/// - Parameter n1: The first number for which to calculate the greatest common
///                 divisor.
/// - Parameter n2: The second number for which to calculate the greatest common
///                 divisor.
///
/// - Returns:  The result of the greatest common divisor calculation.
public func gcd(_ n1: Number,
                _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().greatestCommonDivisor(with: n2.checkInteger())))
}

/// Calculates the least common multiple of the two provided numbers and returns
/// the result.
///
/// - Warning:  This operation is only defined for integers. Both operands must
///             be integers; applying this operation to non-integers will result
///             in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (lcm n1 n2) ; R5RS and R7RS
/// ```
///
/// - Parameter n1: The first number for which to calculate the least common
///                 multiple.
/// - Parameter n2: The second number for which to calculate the least common
///                 multiple.
///
/// - Returns:  The result of the least common multiple calculation.
public func lcm(_ n1: Number,
                _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().leastCommonMultiple(with: n2.checkInteger())))
}

/// Calculates the natural logarithm of the provided number and returns the
/// result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (log z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the logarithm.
///
/// - Returns:  The result of the logarithm calculation.
public func log(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.logarithm()))

    case let .real(val):
        Number(.real(val.logarithm()))
    }
}

/// Calculates the logarithm of the provided number for the specified base and
/// returns the result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (log z base) ; R7RS
/// ```
///
/// - Parameter z:      The number for which to calculate the logarithm.
/// - Parameter base:   The base of the logarithm to calculate.
///
/// - Returns:  The result of the logarithm calculation.
public func log(_ z: Number,
                base: Number) -> Number {
    switch (z.value, base.value) {
    case let (.complex(val1), .complex(val2)):
        Number(.complex(val1.logarithm(base: val2)))

    case let (.real(val1), .real(val2)):
        Number(.real(val1.logarithm(base: val2)))

    default:
        Number(.complex(z.toComplex().logarithm(base: base.toComplex())))
    }
}

/// Calculates the base-10 logarithm of the provided number and returns the
/// result.
///
/// - Parameter z:  The number for which to calculate the logarithm.
///
/// - Returns:  The result of the logarithm calculation.
public func log10(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.logarithmBase10()))

    case let .real(val):
        Number(.real(val.logarithmBase10()))
    }
}

/// Calculates the base-2 logarithm of the provided number and returns the
/// result.
///
/// - Parameter z:  The number for which to calculate the logarithm.
///
/// - Returns:  The result of the logarithm calculation.
public func log2(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.logarithmBase2()))

    case let .real(val):
        Number(.real(val.logarithmBase2()))
    }
}

/// Determines the greater of the two provided numbers and returns the result.
///
/// - Warning:  This operation is only defined for real numbers. Both operands
///             must be real numbers; applying this operation to complex numbers
///             with a nonzero imaginary part will result in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (max x1 x2) ; R5RS and R7RS
/// ```
///
/// - Parameter x1: The first number to compare.
/// - Parameter x2: The second number to compare.
///
/// - Returns:  The greater of `x1` and `x2`. If `x1` is equal to `x2`, returns
///             `x1`.
public func max(_ x1: Number,
                _ x2: Number) -> Number {
    x1 < x2 ? x2 : x1
}

/// Determines the lesser of the two provided numbers and returns the result.
///
/// - Warning:  This operation is only defined for real numbers. Both operands
///             must be real numbers; applying this operation to complex numbers
///             with a nonzero imaginary part will result in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (min x1 x2) ; R5RS and R7RS
/// ```
///
/// - Parameter x1: The first number to compare.
/// - Parameter x2: The second number to compare.
///
/// - Returns:  The lesser of `x1` and `x2`. If `x1` is equal to `x2`, returns
///             `x1`.
public func min(_ x1: Number,
                _ x2: Number) -> Number {
    x1 > x2 ? x2 : x1
}

/// Calculates the modulo of the first provided number divided by the second and
/// returns the result.
///
/// - Warning:  This operation is only defined for integers. Both operands must
///             be integers; applying this operation to non-integers will result
///             in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (modulo n1 n2) ; R5RS and R7RS
/// ```
///
/// - Parameter n1: The number to divide by the other.
/// - Parameter n2: The number by which to divide the other.
///
/// - Returns:  The result of the modulo calculation.
public func modulo(_ n1: Number,
                   _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().modulo(n2.checkInteger())))
}

/// Calculates the quotient of the first provided number divided by the second
/// and returns the result.
///
/// - Warning:  This operation is only defined for integers. Both operands must
///             be integers; applying this operation to non-integers will result
///             in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (quotient n1 n2) ; R5RS and R7RS
/// ```
///
/// - Parameter n1: The number to divide by the other.
/// - Parameter n2: The number by which to divide the other.
///
/// - Returns:  The result of the quotient calculation.
public func quotient(_ n1: Number,
                     _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().quotient(dividingBy: n2.checkInteger())))
}

/// Determines the _simplest_ rational number differing from the first provided
/// number by no more than the second and returns the result.
///
/// - Warning:  This operation is only defined for real numbers. Both operands
///             must be real numbers; applying this operation to complex numbers
///             with nonzero imaginary parts will result in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (rationalize x y) ; R5RS and R7RS
/// ```
///
/// - Parameter x:  The number to rationalize.
/// - Parameter y:  The number within which to rationalize the other.
///
/// - Returns:  The rationalized result.
public func rationalize(_ x: Number,
                        _ y: Number) -> Number {
    guard let result = x.checkReal().rationalize(within: y.checkReal())
    else { fatalError("no rational representation of \(x) within \(y)") }

    return Number(.real(result))
}

/// Calculates the remainder of the first provided number divided by the second
/// and returns the result.
///
/// - Warning:  This operation is only defined for integers. Both operands must
///             be integers; applying this operation to non-integers will result
///             in a fatal error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (remainder n1 n2) ; R5RS and R7RS
/// ```
///
/// - Parameter n1: The number to divide by the other.
/// - Parameter n2: The number by which to divide the other.
///
/// - Returns:  The result of the remainder calculation.
public func remainder(_ n1: Number,
                      _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().remainder(dividingBy: n2.checkInteger())))
}

/// Determines the closest integer to the provided number, rounding to even when
/// the provided number is halfway between two integers, and returns the result.
///
/// This function rounds to even for consistency with the default rounding mode
/// specified by the IEEE 754 IEEE floating-point standard.
///
/// If the provided number is inexact, then the result will also be inexact. If
/// the provided number is infinite or a NaN, then it is returned.
///
/// - Warning:  This operation is only defined for real numbers. The operand
///             must be a real number; applying this operation to a complex
///             number with a nonzero imaginary part will result in a fatal
///             error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (round x) ; R5RS and R7RS
/// ```
///
/// - Parameter x:  The number to round.
///
/// - Returns:  The rounded result.
public func round(_ x: Number) -> Number {
    Number(.real(x.checkReal().round()))
}

/// Calculates the sine of the provided number and returns the result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (sin z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the sine.
///
/// - Returns:  The result of the sine calculation.
public func sin(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.sine()))

    case let .real(val):
        Number(.real(val.sine()))
    }
}

/// Calculates the hyperbolic sine of the provided number and returns the
/// result.
///
/// - Parameter z:  The number for which to calculate the hyperbolic sine.
///
/// - Returns:  The result of the hyperbolic sine calculation.
public func sinh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.hyperbolicSine()))

    case let .real(val):
        Number(.real(val.hyperbolicSine()))
    }
}

/// Calculates the square root of the provided number and returns the result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (sqrt z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the square root.
///
/// - Returns:  The result of the square root calculation.
public func sqrt(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.squareRoot()))

    case let .real(val):
        if val.isNegative {
            Number(.complex(z.toComplex().squareRoot()))
        } else {
            Number(.real(val.squareRoot()))
        }
    }
}

/// Calculates the tangent of the provided number and returns the result.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (tan z) ; R5RS and R7RS
/// ```
///
/// - Parameter z:  The number for which to calculate the tangent.
///
/// - Returns:  The result of the tangent calculation.
public func tan(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.tangent()))

    case let .real(val):
        Number(.real(val.tangent()))
    }
}

/// Calculates the hyperbolic tangent of the provided number and returns the
/// result.
///
/// - Parameter z:  The number for which to calculate the hyperbolic tangent.
///
/// - Returns:  The result of the hyperbolic tangent calculation.
public func tanh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.hyperbolicTangent()))

    case let .real(val):
        Number(.real(val.hyperbolicTangent()))
    }
}

/// Determines the integer closest to the provided number whose absolute value
/// is not larger than the absolute value of the provided number and returns the
/// result.
///
/// If the provided number is inexact, then the result will also be inexact. If
/// the provided number is infinite or a NaN, then it is returned.
///
/// - Warning:  This operation is only defined for real numbers. The operand
///             must be a real number; applying this operation to a complex
///             number with a nonzero imaginary part will result in a fatal
///             error.
///
/// The equivalent Scheme procedure is:
///
/// ```
/// (truncate x) ; R5RS and R7RS
/// ```
///
/// - Parameter x:  The number to truncate.
///
/// - Returns:  The truncated result.
public func truncate(_ x: Number) -> Number {
    Number(.real(x.checkReal().truncate()))
}
