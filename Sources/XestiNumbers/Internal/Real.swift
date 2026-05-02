// © 2025–2026 John Gary Pusey (see LICENSE.md)

// swiftlint:disable file_length

private import XestiTools

internal struct Real {

    // MARK: Internal Nested Types

    internal enum Value {
        case exactInteger(ExactInteger)
        case floatingPoint(FloatingPoint)
        case fraction(Fraction)
    }

    // MARK: Internal Type Properties

    internal static let exactOne         = Self(.exactInteger(.one))
    internal static let exactZero        = Self(.exactInteger(.zero))
    internal static let inexactOne       = Self(.floatingPoint(.one))
    internal static let inexactZero      = Self(.floatingPoint(.zero))
    internal static let nan              = Self(.floatingPoint(.nan))
    internal static let negativeInfinity = Self(.floatingPoint(.negativeInfinity))
    internal static let pi               = Self(.floatingPoint(.pi))
    internal static let positiveInfinity = Self(.floatingPoint(.positiveInfinity))

    // MARK: Internal Initializers

    internal init(_ value: Value) {
        self.value = value
    }

    // MARK: Internal Instance Properties

    internal let value: Value
}

extension Real {

    // MARK: Internal Type Methods

    internal static func parse(input: String,
                               radix: Number.Radix,
                               exactness: Number.Exactness) -> Self? {
        if let rval = ExactInteger.parse(input: input,
                                         radix: radix) {
            if exactness == .inexact {
                return Self(.floatingPoint(rval.floatingPointValue))
            }

            return Self(.exactInteger(rval))
        }

        if let rval = Fraction.parse(input: input,
                                     radix: radix) {
            if exactness == .inexact {
                let nval = rval.numerator.floatingPointValue
                let dval = rval.denominator.floatingPointValue

                return Self(.floatingPoint(nval.divided(by: dval)))
            }

            return Self(.fraction(rval))
        }

        if radix == .decimal,
           exactness != .exact,
           let rval = FloatingPoint.parse(input: input) {
            return Self(.floatingPoint(rval))
        }

        return nil
    }

    // MARK: Internal Initializers

    internal init<T: BinaryFloatingPoint>(_ value: T) {
        self.init(.floatingPoint(FloatingPoint(value)))
    }

    internal init<T: BinaryInteger>(_ value: T) {
        self.init(.exactInteger(ExactInteger(value)))
    }

    internal init(numerator: ExactInteger,
                  denominator: ExactInteger) {
        self.init(.fraction(Fraction(numerator: numerator,
                                     denominator: denominator)))
    }

    internal init<T: BinaryInteger>(numerator: T,
                                    denominator: T) {
        self.init(.fraction(Fraction(numerator: ExactInteger(numerator),
                                     denominator: ExactInteger(denominator))))
    }

    // MARK: Internal Instance Properties

    internal var angle: Self {
        switch value {
        case let .exactInteger(val):
            if val.isNegative {
                .pi
            } else {
                .exactZero
            }

        case let .floatingPoint(val):
            if val.isNegative {
                .pi
            } else {
                .inexactZero
            }

        case let .fraction(val):
            if val.isNegative {
                .pi
            } else {
                .exactZero
            }
        }
    }

    internal var denominator: Self {
        switch value {
        case .exactInteger:
                .exactOne

        case let .floatingPoint(val):
            if val.isInteger {
                .inexactOne
            } else {
                Self(.floatingPoint(_toFraction().denominator.floatingPointValue))
            }

        case let .fraction(val):
            Self(.exactInteger(val.denominator))
        }
    }

    internal var exact: Self {
        switch value {
        case .exactInteger, .fraction:
            self

        case let .floatingPoint(val):
            if val.isInteger {
                Self(.exactInteger(val.exactIntegerValue))
            } else {
                Self(.fraction(val.fractionValue))
            }
        }
    }

    internal var exactIntegerValue: ExactInteger {
        switch value {
        case let .exactInteger(val):
            val

        case let .floatingPoint(val):
            val.exactIntegerValue

        case let .fraction(val):
            val.exactIntegerValue
        }
    }

    internal var floatingPointValue: FloatingPoint {
        switch value {
        case let .exactInteger(val):
            val.floatingPointValue

        case let .floatingPoint(val):
            val

        case let .fraction(val):
            val.floatingPointValue
        }
    }

    internal var inexact: Self {
        switch value {
        case let .exactInteger(val):
            Self(.floatingPoint(val.floatingPointValue))

        case .floatingPoint:
            self

        case let .fraction(val):
            Self(.floatingPoint(val.numerator.floatingPointValue.divided(by: val.denominator.floatingPointValue)))
        }
    }

    internal var isEven: Bool {
        _toInteger().value.isEven
    }

    internal var isExact: Bool {
        switch value {
        case .exactInteger, .fraction:
            true

        case .floatingPoint:
            false
        }
    }

    internal var isFinite: Bool {
        switch value {
        case .exactInteger, .fraction:
            true

        case let .floatingPoint(val):
            val.isFinite
        }
    }

    internal var isInexact: Bool {
        switch value {
        case .exactInteger, .fraction:
            false

        case .floatingPoint:
            true
        }
    }

    internal var isInfinite: Bool {
        switch value {
        case .exactInteger, .fraction:
            false

        case let .floatingPoint(val):
            val.isInfinite
        }
    }

    internal var isInteger: Bool {
        switch value {
        case .exactInteger:
            true

        case let .floatingPoint(val):
            val.isInteger

        case let .fraction(val):
            val.isInteger
        }
    }

    internal var isNaN: Bool {
        switch value {
        case .exactInteger, .fraction:
            false

        case let .floatingPoint(val):
            val.isNaN
        }
    }

    internal var isNegative: Bool {
        switch value {
        case let .exactInteger(val):
            val.isNegative

        case let .floatingPoint(val):
            val.isNegative

        case let .fraction(val):
            val.isNegative
        }
    }

    internal var isOdd: Bool {
        _toInteger().value.isOdd
    }

    internal var isPositive: Bool {
        switch value {
        case let .exactInteger(val):
            val.isPositive

        case let .floatingPoint(val):
            val.isPositive

        case let .fraction(val):
            val.isPositive
        }
    }

    internal var isRational: Bool {
        switch value {
        case .exactInteger, .fraction:
            true

        case let .floatingPoint(val):
            val.isFinite
        }
    }

    internal var isZero: Bool {
        switch value {
        case let .exactInteger(val):
            val.isZero

        case let .floatingPoint(val):
            val.isZero

        case let .fraction(val):
            val.isZero
        }
    }

    internal var numerator: Self {
        switch value {
        case .exactInteger:
            self

        case let .floatingPoint(val):
            if val.isInteger {
                self
            } else {
                Self(.floatingPoint(_toFraction().numerator.floatingPointValue))
            }

        case let .fraction(val):
            Self(.exactInteger(val.numerator))
        }
    }

    internal var simplified: Self {
        switch value {
        case .exactInteger, .floatingPoint:
            self

        case let .fraction(val):
            if val.denominator.isEqual(to: .one) {
                Self(.exactInteger(val.numerator))
            } else {
                self
            }
        }
    }

    // MARK: Internal Instance Methods

    internal func absoluteValue() -> Self {
        switch value {
        case let .exactInteger(val):
            if val.isNegative {
                Self(.exactInteger(val.negated()))
            } else {
                self
            }

        case let .floatingPoint(val):
            if val.isNegative {
                Self(.floatingPoint(val.negated()))
            } else {
                self
            }

        case let .fraction(val):
            if val.isNegative {
                Self(.fraction(val.negated()))
            } else {
                self
            }
        }
    }

    internal func adding(_ other: Self) -> Self {
        switch (value, other.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            Self(.exactInteger(val1.adding(val2)))

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            Self(.floatingPoint(val1.adding(val2)))

        case let (.fraction(val1), .fraction(val2)):
            Self(.fraction(val1.adding(val2)))

        case (.floatingPoint, _), (_, .floatingPoint):
            Self(.floatingPoint(_toFloatingPoint().adding(other._toFloatingPoint())))

        case (.fraction, _), (_, .fraction):
            Self(.fraction(_toFraction().adding(other._toFraction())))
        }
    }

    internal func bitwiseAnd(with other: Self) -> Self {
        let (val1, inexact1) = _toInteger()
        let (val2, inexact2) = other._toInteger()
        let rval = val1.bitwiseAnd(with: val2)

        if inexact1 || inexact2 {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func bitwiseNot() -> Self {
        let (val, inexact) = _toInteger()
        let rval = val.bitwiseNot()

        if inexact {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func bitwiseOr(with other: Self) -> Self {
        let (val1, inexact1) = _toInteger()
        let (val2, inexact2) = other._toInteger()
        let rval = val1.bitwiseOr(with: val2)

        if inexact1 || inexact2 {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func bitwiseShiftLeft(bits: Int) -> Self {
        let (val, inexact) = _toInteger()
        let rval = val.bitwiseShiftLeft(bits: bits)

        if inexact {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func bitwiseShiftRight(bits: Int) -> Self {
        let (val, inexact) = _toInteger()
        let rval = val.bitwiseShiftRight(bits: bits)

        if inexact {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func bitwiseXor(with other: Self) -> Self {
        let (val1, inexact1) = _toInteger()
        let (val2, inexact2) = other._toInteger()
        let rval = val1.bitwiseXor(with: val2)

        if inexact1 || inexact2 {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func ceiling() -> Self {
        switch value {
        case .exactInteger:
            self

        case let .floatingPoint(val):
            Self(.floatingPoint(val.ceiling()))

        case let .fraction(val):
            Self(.exactInteger(val.ceiling()))
        }
    }

    internal func cosine() -> Self {
        Self(.floatingPoint(_toFloatingPoint().cosine()))
    }

    internal func divided(by other: Self) -> Self {
        guard !other.isZero
        else { fatalError("zero divisor") }

        switch (value, other.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            if val1.isMultiple(of: val2) {
                return Self(.exactInteger(val1.quotient(dividingBy: val2)))
            } else {
                return Self(.fraction(Fraction(numerator: val1,
                                               denominator: val2)))
            }

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return Self(.floatingPoint(val1.divided(by: val2)))

        case let (.fraction(val1), .fraction(val2)):
            return Self(.fraction(val1.divided(by: val2)))

        case (.floatingPoint, _), (_, .floatingPoint):
            return Self(.floatingPoint(_toFloatingPoint().divided(by: other._toFloatingPoint())))

        case (.fraction, _), (_, .fraction):
            return Self(.fraction(_toFraction().divided(by: other._toFraction())))
        }
    }

    internal func exponential() -> Self {
        Self(.floatingPoint(_toFloatingPoint().exponential()))
    }

    internal func exponential(base: Self) -> Self {
        Self(.floatingPoint(_toFloatingPoint().exponential(base: base._toFloatingPoint())))
    }

    internal func exponentialBase10() -> Self {
        Self(.floatingPoint(_toFloatingPoint().exponentialBase10()))
    }

    internal func exponentialBase2() -> Self {
        Self(.floatingPoint(_toFloatingPoint().exponentialBase2()))
    }

    internal func floor() -> Self {
        switch value {
        case .exactInteger:
            self

        case let .floatingPoint(val):
            Self(.floatingPoint(val.floor()))

        case let .fraction(val):
            Self(.exactInteger(val.floor()))
        }
    }

    internal func greatestCommonDivisor(with other: Self) -> Self {
        let (val1, inexact1) = _toInteger()
        let (val2, inexact2) = other._toInteger()
        let rval = val1.greatestCommonDivisor(with: val2)

        if inexact1 || inexact2 {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func hyperbolicCosine() -> Self {
        Self(.floatingPoint(_toFloatingPoint().hyperbolicCosine()))
    }

    internal func hyperbolicSine() -> Self {
        Self(.floatingPoint(_toFloatingPoint().hyperbolicSine()))
    }

    internal func hyperbolicTangent() -> Self {
        Self(.floatingPoint(_toFloatingPoint().hyperbolicTangent()))
    }

    internal func hypotenuse(with other: Self) -> Self {
        Self(.floatingPoint(_toFloatingPoint().hypotenuse(with: other._toFloatingPoint())))
    }

    internal func inverseCosine() -> Self {
        Self(.floatingPoint(_toFloatingPoint().inverseCosine()))
    }

    internal func inverseHyperbolicCosine() -> Self {
        Self(.floatingPoint(_toFloatingPoint().inverseHyperbolicCosine()))
    }

    internal func inverseHyperbolicSine() -> Self {
        Self(.floatingPoint(_toFloatingPoint().inverseHyperbolicSine()))
    }

    internal func inverseHyperbolicTangent() -> Self {
        Self(.floatingPoint(_toFloatingPoint().inverseHyperbolicTangent()))
    }

    internal func inverseSine() -> Self {
        Self(.floatingPoint(_toFloatingPoint().inverseSine()))
    }

    internal func inverseTangent() -> Self {
        Self(.floatingPoint(_toFloatingPoint().inverseTangent()))
    }

    internal func inverseTangent(_ other: Self) -> Self {
        Self(.floatingPoint(_toFloatingPoint().inverseTangent(other._toFloatingPoint())))
    }

    internal func isEqual(to other: Self) -> Bool {
        switch (value, other.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            val1.isEqual(to: val2)

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            val1.isEqual(to: val2)

        case let (.fraction(val1), .fraction(val2)):
            val1.isEqual(to: val2)

        case (.floatingPoint, _), (_, .floatingPoint):
            _toFloatingPoint().isEqual(to: other._toFloatingPoint())

        case (.fraction, _), (_, .fraction):
            _toFraction().isEqual(to: other._toFraction())
        }
    }

    internal func isLess(than other: Self) -> Bool {
        switch (value, other.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            val1.isLess(than: val2)

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            val1.isLess(than: val2)

        case let (.fraction(val1), .fraction(val2)):
            val1.isLess(than: val2)

        case (.floatingPoint, _), (_, .floatingPoint):
            _toFloatingPoint().isLess(than: other._toFloatingPoint())

        case (.fraction, _), (_, .fraction):
            _toFraction().isLess(than: other._toFraction())
        }
    }

    internal func leastCommonMultiple(with other: Self) -> Self {
        let (val1, inexact1) = _toInteger()
        let (val2, inexact2) = other._toInteger()
        let rval = val1.leastCommonMultiple(with: val2)

        if inexact1 || inexact2 {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func logarithm() -> Self {
        Self(.floatingPoint(_toFloatingPoint().logarithm()))
    }

    internal func logarithm(base: Self) -> Self {
        Self(.floatingPoint(_toFloatingPoint().logarithm(base: base._toFloatingPoint())))
    }

    internal func logarithmBase10() -> Self {
        Self(.floatingPoint(_toFloatingPoint().logarithmBase10()))
    }

    internal func logarithmBase2() -> Self {
        Self(.floatingPoint(_toFloatingPoint().logarithmBase2()))
    }

    internal func modulo(_ other: Self) -> Self {
        let (val1, inexact1) = _toInteger()
        let (val2, inexact2) = other._toInteger()
        let rval = val1.modulo(val2)

        if inexact1 || inexact2 {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func multiplied(by other: Self) -> Self {
        switch (value, other.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            Self(.exactInteger(val1.multiplied(by: val2)))

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            Self(.floatingPoint(val1.multiplied(by: val2)))

        case let (.fraction(val1), .fraction(val2)):
            Self(.fraction(val1.multiplied(by: val2)))

        case (.floatingPoint, _), (_, .floatingPoint):
            Self(.floatingPoint(_toFloatingPoint().multiplied(by: other._toFloatingPoint())))

        case (.fraction, _), (_, .fraction):
            Self(.fraction(_toFraction().multiplied(by: other._toFraction())))
        }
    }

    internal func negated() -> Self {
        switch value {
        case let .exactInteger(val):
            Self(.exactInteger(val.negated()))

        case let .floatingPoint(val):
            Self(.floatingPoint(val.negated()))

        case let .fraction(val):
            Self(.fraction(val.negated()))
        }
    }

    internal func quotient(dividingBy other: Self) -> Self {
        let (val1, inexact1) = _toInteger()
        let (val2, inexact2) = other._toInteger()
        let rval = val1.quotient(dividingBy: val2)

        if inexact1 || inexact2 {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func rationalize(within other: Self) -> Self? {
        guard !isNaN, !other.isNaN
        else { return .nan }

        func findBetween(_ lo: Self,
                         _ hi: Self) -> Self? {
            if lo.isInteger {
                return lo
            } else {
                let loInt = lo.floor()
                let hiInt = hi.floor()

                if loInt.isLess(than: hiInt) {
                    return loInt.adding(.exactOne)
                } else {
                    let loNew = Self.exactOne.divided(by: hi.subtracting(loInt))
                    let hiNew = Self.exactOne.divided(by: lo.subtracting(loInt))

                    guard let tmp = findBetween(loNew, hiNew)
                    else { return nil }

                    return loInt.adding(Self.exactOne.divided(by: tmp))
                }
            }
        }

        func doFindBetween(_ lo: Self,
                           _ hi: Self) -> Self? {
            if lo.isNegative {
                findBetween(hi.negated(), lo.negated())?.negated()
            } else {
                findBetween(lo, hi)
            }
        }

        let delta = other.absoluteValue()
        let lo = subtracting(delta)
        let hi = adding(delta)

        guard !isInfinite
        else { return delta.isInfinite ? .nan : self }

        guard !delta.isInfinite
        else { return .inexactZero }

        guard lo.isPositive || hi.isNegative
        else { return isExact ? .exactZero : .inexactZero }

        if lo.isInexact || hi.isInexact {
            return doFindBetween(lo.exact, hi.exact)?.inexact
        }

        return doFindBetween(lo, hi)
    }

    internal func remainder(dividingBy other: Self) -> Self {
        let (val1, inexact1) = _toInteger()
        let (val2, inexact2) = other._toInteger()
        let rval = val1.remainder(dividingBy: val2)

        if inexact1 || inexact2 {
            return Self(.floatingPoint(rval.floatingPointValue))
        }

        return Self(.exactInteger(rval))
    }

    internal func round() -> Self {
        switch value {
        case .exactInteger:
            self

        case let .floatingPoint(val):
            Self(.floatingPoint(val.round()))

        case let .fraction(val):
            Self(.exactInteger(val.round()))
        }
    }

    internal func sine() -> Self {
        Self(.floatingPoint(_toFloatingPoint().sine()))
    }

    internal func squareRoot() -> Self {
        Self(.floatingPoint(_toFloatingPoint().squareRoot()))
    }

    internal func subtracting(_ other: Self) -> Self {
        switch (value, other.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            Self(.exactInteger(val1.subtracting(val2)))

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            Self(.floatingPoint(val1.subtracting(val2)))

        case let (.fraction(val1), .fraction(val2)):
            Self(.fraction(val1.subtracting(val2)))

        case (.floatingPoint, _), (_, .floatingPoint):
            Self(.floatingPoint(_toFloatingPoint().subtracting(other._toFloatingPoint())))

        case (.fraction, _), (_, .fraction):
            Self(.fraction(_toFraction().subtracting(other._toFraction())))
        }
    }

    internal func tangent() -> Self {
        Self(.floatingPoint(_toFloatingPoint().tangent()))
    }

    internal func truncate() -> Self {
        switch value {
        case .exactInteger:
            self

        case let .floatingPoint(val):
            Self(.floatingPoint(val.truncate()))

        case let .fraction(val):
            Self(.exactInteger(val.truncate()))
        }
    }

    // MARK: Private Instance Methods

    private func _toInteger() -> (value: ExactInteger, inexact: Bool) {
        switch value {
        case let .exactInteger(val):
            (val, false)

        case let .floatingPoint(val) where val.isInteger:
            (val.exactIntegerValue, true)

        case let .fraction(val) where val.isInteger:
            (val.numerator, false)

        default:
            fatalError("\(value) must be an integer")
        }
    }

    private func _toFloatingPoint() -> FloatingPoint {
        switch value {
        case let .exactInteger(val):
            val.floatingPointValue

        case let .floatingPoint(val):
            val

        case let .fraction(val):
            val.numerator.floatingPointValue.divided(by: val.denominator.floatingPointValue)
        }
    }

    private func _toFraction() -> Fraction {
        switch value {
        case let .exactInteger(val):
            return Fraction(numerator: val,
                            denominator: .one,
                            reduce: false)

        case let .floatingPoint(val):
            let (num, den) = val.doubleValue.rationalized()

            return Fraction(numerator: ExactInteger(num),
                            denominator: ExactInteger(den))

        case let .fraction(val):
            return val
        }
    }
}

// MARK: - CustomDebugStringConvertible

extension Real: CustomDebugStringConvertible {
    internal var debugDescription: String {
        switch value {
        case let .exactInteger(val):
            String(reflecting: val)

        case let .floatingPoint(val):
            String(reflecting: val)

        case let .fraction(val):
            String(reflecting: val)
        }
    }
}

// MARK: - CustomStringConvertible

extension Real: CustomStringConvertible {
    internal var description: String {
        switch value {
        case let .exactInteger(val):
            String(describing: val)

        case let .floatingPoint(val):
            String(describing: val)

        case let .fraction(val):
            String(describing: val)
        }
    }
}

// MARK: - Sendable

extension Real: Sendable {
}
