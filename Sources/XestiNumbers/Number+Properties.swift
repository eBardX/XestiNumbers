// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Instance Properties

    /// The angle (also known as the “argument” or “phase”) of this number.
    ///
    /// The equivalent Scheme procedure is:
    ///
    /// ```
    /// (angle z) ; R5RS and R7RS
    /// ```
    public var angle: Self {
        switch value {
        case let .complex(val):
            Self(.real(val.angle))

        case let .real(val):
            Self(.real(val.angle))
        }
    }

    /// The denominator of this number.
    ///
    /// The denominator is always positive. If the number is an integer, the
    /// denominator is one.
    ///
    /// - Warning:  This operation is only defined for rational numbers. This
    ///             number must be a rational number; applying this predicate to
    ///             a non-rational number will result in a fatal error.
    ///
    /// The equivalent Scheme procedure is:
    ///
    /// ```
    /// (denominator q) ; R5RS and R7RS
    /// ```
    public var denominator: Self {
        Self(.real(checkRational().denominator))
    }

    /// An exact representation of this number.
    ///
    /// Returns the exact number that is numerically closest to this number. If
    /// this number is already exact, then this number itself is returned.
    ///
    /// - Warning:  This operation is only defined for finite numbers. This
    ///             number must be finite; applying this operation to an
    ///             infinite or NaN value will result in a fatal error.
    ///
    /// The equivalent Scheme procedure is:
    ///
    /// ```
    /// (inexact->exact z) ; R5RS
    /// (exact z)          ; R7RS
    /// ```
    public var exact: Self {
        switch value {
        case let .complex(val) where val.isFinite:
            val.isInexact ? Self(.complex(val.exact)) : self

        case let .real(val) where val.isFinite:
            val.isInexact ? Self(.real(val.exact)) : self

        default:
            fatalError("No exact representation of \(self)")
        }
    }

    /// The imaginary part of this number.
    ///
    /// The equivalent Scheme procedure is:
    ///
    /// ```
    /// (imag-part z) ; R5RS and R7RS
    /// ```
    public var imaginaryPart: Self {
        switch value {
        case let .complex(val):
            Self(.real(val.imaginaryPart))

        case let .real(val):
            Self(.real(val.isExact ? .exactZero : .inexactZero))
        }
    }

    /// An inexact representation of this number.
    ///
    /// Returns the inexact number that is numerically closest to this number.
    /// If this number is already inexact, then this number itself is returned.
    ///
    /// The equivalent Scheme procedure is:
    ///
    /// ```
    /// (exact->inexact z) ; R5RS
    /// (inexact z)        ; R7RS
    /// ```
    public var inexact: Self {
        switch value {
        case let .complex(val):
            val.isExact ? Self(.complex(val.inexact)) : self

        case let .real(val):
            val.isExact ? Self(.real(val.inexact)) : self
        }
    }

    /// A Boolean value indicating whether this number is a complex number.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (complex? obj) ; R5RS and R7RS
    /// ```
    public var isComplex: Bool {
        true
    }

    /// A Boolean value indicating whether this number is even.
    ///
    /// - Warning:  This predicate is only defined for integers. This number
    ///             must be an integer; applying this predicate to a non-integer
    ///             will result in a fatal error.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (even? n) ; R5RS and R7RS
    /// ```
    public var isEven: Bool {
        checkInteger().isEven
    }

    /// A Boolean value indicating whether this number is represented exactly.
    ///
    /// An exact complex number has an exact real part and an exact imaginary
    /// part.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (exact? z) ; R5RS and R7RS
    /// ```
    public var isExact: Bool {
        switch value {
        case let .complex(val):
            val.isExact

        case let .real(val):
            val.isExact
        }
    }

    /// A Boolean value indicating whether this number is finite.
    ///
    /// For NaN, both `isFinite` and `isInfinite` return `false`.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (finite? z) ; R7RS
    /// ```
    public var isFinite: Bool {
        switch value {
        case let .complex(val):
            val.isFinite

        case let .real(val):
            val.isFinite
        }
    }

    /// A Boolean value indicating whether this number is represented inexactly.
    ///
    /// An inexact complex number has an inexact real part or an inexact
    /// imaginary part or both.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (inexact? z) ; R5RS and R7RS
    /// ```
    public var isInexact: Bool {
        switch value {
        case let .complex(val):
            val.isInexact

        case let .real(val):
            val.isInexact
        }
    }

    /// A Boolean value indicating whether this number is infinite.
    ///
    /// For NaN, both `isFinite` and `isInfinite` return `false`.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (infinite? z) ; R7RS
    /// ```
    public var isInfinite: Bool {
        switch value {
        case let .complex(val):
            val.isInfinite

        case let .real(val):
            val.isInfinite
        }
    }

    /// A Boolean value indicating whether this number is an integer.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (integer? obj) ; R5RS and R7RS
    /// ```
    public var isInteger: Bool {
        switch value {
        case let .complex(val):
            val.isInteger

        case let .real(val):
            val.isInteger
        }
    }

    /// A Boolean value indicating whether this number is NaN.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (nan? z) ; R7RS
    /// ```
    public var isNaN: Bool {
        switch value {
        case let .complex(val):
            val.isNaN

        case let .real(val):
            val.isNaN
        }
    }

    /// A Boolean value indicating whether this number is less than zero.
    ///
    /// - Warning:  This predicate is only defined for real numbers. This number
    ///             must be a real number; applying this predicate to a complex
    ///             number with a nonzero imaginary part will result in a fatal
    ///             error.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (negative? x) ; R5RS and R7RS
    /// ```
    public var isNegative: Bool {
        checkReal().isNegative
    }

    /// A Boolean value indicating whether this number is odd.
    ///
    /// - Warning:  This predicate is only defined for integers. This number
    ///             must be an integer; applying this predicate to a non-integer
    ///             will result in a fatal error.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (odd? n) ; R5RS and R7RS
    /// ```
    public var isOdd: Bool {
        checkInteger().isOdd
    }

    /// A Boolean value indicating whether this number is greater than zero.
    ///
    /// - Warning:  This predicate is only defined for real numbers. This number
    ///             must be a real number; applying this predicate to a complex
    ///             number with a nonzero imaginary part will result in a fatal
    ///             error.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (positive? x) ; R5RS and R7RS
    /// ```
    public var isPositive: Bool {
        checkReal().isPositive
    }

    /// A Boolean value indicating whether this number is a rational number.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (rational? obj) ; R5RS and R7RS
    /// ```
    public var isRational: Bool {
        switch value {
        case let .complex(val):
            val.isRational

        case let .real(val):
            val.isRational
        }
    }

    /// A Boolean value indicating whether this number is a real number.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (real? obj) ; R5RS and R7RS
    /// ```
    public var isReal: Bool {
        switch value {
        case let .complex(val):
            val.isReal

        case .real:
            true
        }
    }

    /// A Boolean value indicating whether this number is equal to zero.
    ///
    /// The equivalent Scheme predicate is:
    ///
    /// ```
    /// (zero? z) ; R5RS and R7RS
    /// ```
    public var isZero: Bool {
        switch value {
        case let .complex(val):
            val.isZero

        case let .real(val):
            val.isZero
        }
    }

    /// The magnitude (also known as the “absolute value” or “modulus”) of this number.
    ///
    /// The equivalent Scheme procedure is:
    ///
    /// ```
    /// (magnitude z) ; R5RS and R7RS
    /// ```
    public var magnitude: Self {
        switch value {
        case let .complex(val):
            Self(.real(val.magnitude))

        case let .real(val):
            Self(.real(val.absoluteValue()))
        }
    }

    /// The numerator of this number.
    ///
    /// - Warning:  This operation is only defined for rational numbers. This
    ///             number must be a rational number; applying this predicate to
    ///             a non-rational number will result in a fatal error.
    ///
    /// The equivalent Scheme procedure is:
    ///
    /// ```
    /// (numerator q) ; R5RS and R7RS
    /// ```
    public var numerator: Self {
        Self(.real(checkRational().numerator))
    }

    /// The real part of this number.
    ///
    /// The equivalent Scheme procedure is:
    ///
    /// ```
    /// (real-part z) ; R5RS and R7RS
    /// ```
    public var realPart: Self {
        switch value {
        case let .complex(val):
            Self(.real(val.realPart))

        case .real:
            self
        }
    }

    /// The simplest internal representation of this number.
    ///
    /// If this number is already in the simplest internal representation, then
    /// this number itself is returned.
    ///
    /// A number may be represented internally by a variety of data structures.
    /// For example, there are different data structures for representing
    /// “large” and “small” exact integers, exact fractions, floating-point
    /// values, and complex numbers. Performing a numeric operation may result
    /// in a number with a representation containing extraneous information.
    ///
    /// For example, the  numbers `5/4` and `3/4` are represented internally by
    /// data structures that contain the numerator and denominator of each
    /// number. (Something like, `{ numerator: 5, denominator: 4 }` and `{
    /// numerator: 3, denominator: 4 }`, respectively.) Adding those numbers
    /// together results in the number `2`. However, for efficiency, that result
    /// is also represented internally by a data structure that contains _both_
    /// a numerator _and_ a denominator. (Something like, `{ numerator: 2,
    /// denominator: 1 }`.) In this case, the `simplified` property would
    /// simplify the internal representation to contain _only_ the (exact)
    /// integer result.
    public var simplified: Self {
        switch value {
        case let .complex(val):
            if val.isReal {
                Self(.real(val.realPart.simplified))
            } else {
                Self(.complex(Complex(realPart: val.realPart.simplified,
                                      imaginaryPart: val.imaginaryPart.simplified)))
            }

        case let .real(val):
            Self(.real(val.simplified))
        }
    }
}
