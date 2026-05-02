// © 2025–2026 John Gary Pusey (see LICENSE.md)

private import Darwin
private import RealModule
private import XestiTools

internal struct FloatingPoint {

    // MARK: Private Initializers

    private init(_ value: Double) {
        self.value = value
    }

    // MARK: Private Instance Properties

    private let value: Double
}

// MARK: -

extension FloatingPoint {

    // MARK: Internal Type Properties

    internal static let nan              = Self(Double.nan)
    internal static let negativeInfinity = Self(-Double.infinity)
    internal static let one              = Self(1.0)
    internal static let pi               = Self(Double.pi)
    internal static let positiveInfinity = Self(Double.infinity)
    internal static let zero             = Self(Double.zero)

    // MARK: Internal Type Methods

    internal static func parse(input: String) -> Self? {
        let lcText = input.lowercased()

        if let tval = _matchFloatingPoint(input: lcText) {
            if let fpval = specials[tval] {
                return Self(fpval)
            }

            if let fpval = Double(tval) {
                return Self(fpval)
            }
        }

        return nil
    }

    // MARK: Internal Initializers

    internal init<T: BinaryFloatingPoint>(_ value: T) {
        if value.isZero {
            self = .zero    // avoid -0.0
        } else if let dblValue = Double(exactly: value) {
            self.init(dblValue)
        } else if value.isInfinite {
            self = value < 0 ? .negativeInfinity : .positiveInfinity
        } else {
            self = .nan
        }
    }

    internal init<T: BinaryInteger>(_ value: T) {
        if let dblValue = Double(exactly: value) {
            self.init(dblValue)
        } else {
            self = .nan
        }
    }

    // MARK: Internal Instance Properties

    internal var doubleValue: Double {
        value
    }

    internal var exactIntegerValue: ExactInteger {
        ExactInteger(value)
    }

    internal var floatValue: Float {
        Float(value)
    }

    internal var fractionValue: Fraction {
        let frac = value.rationalized()

        return Fraction(numerator: ExactInteger(frac.numerator),
                        denominator: ExactInteger(frac.denominator))
    }

    internal var isFinite: Bool {
        value.isFinite
    }

    internal var isInfinite: Bool {
        value.isInfinite
    }

    internal var isInteger: Bool {
        if value.isFinite {
            value == value.rounded(.towardZero)
        } else {
            false
        }
    }

    internal var isNaN: Bool {
        value.isNaN
    }

    internal var isNegative: Bool {
        value < 0
    }

    internal var isPositive: Bool {
        value > 0
    }

    internal var isZero: Bool {
        value.isZero
    }

    // MARK: Internal Instance Methods

    internal func adding(_ other: Self) -> Self {
        Self(value + other.value)
    }

    internal func ceiling() -> Self {
        Self(ceil(value))
    }

    internal func cosine() -> Self {
        Self(Double.cos(value))
    }

    internal func divided(by other: Self) -> Self {
        Self(value / other.value)
    }

    internal func exponential() -> Self {
        Self(Double.exp(value))
    }

    internal func exponential(base: Self) -> Self {
        Self(Double.exp(value * .log(base.value)))
    }

    internal func exponentialBase10() -> Self {
        Self(Double.exp10(value))
    }

    internal func exponentialBase2() -> Self {
        Self(Double.exp2(value))
    }

    internal func floor() -> Self {
        Self(Darwin.floor(value))
    }

    internal func hyperbolicCosine() -> Self {
        Self(Double.cosh(value))
    }

    internal func hyperbolicSine() -> Self {
        Self(Double.sinh(value))
    }

    internal func hyperbolicTangent() -> Self {
        Self(Double.tanh(value))
    }

    internal func hypotenuse(with other: Self) -> Self {
        Self(Double.hypot(value, other.value))
    }

    internal func inverseCosine() -> Self {
        Self(Double.acos(value))
    }

    internal func inverseHyperbolicCosine() -> Self {
        Self(Double.acosh(value))
    }

    internal func inverseHyperbolicSine() -> Self {
        Self(Double.asinh(value))
    }

    internal func inverseHyperbolicTangent() -> Self {
        Self(Double.atanh(value))
    }

    internal func inverseSine() -> Self {
        Self(Double.asin(value))
    }

    internal func inverseTangent() -> Self {
        Self(Double.atan(value))
    }

    internal func inverseTangent(_ other: Self) -> Self {
        Self(Double.atan2(y: value,
                          x: other.value))
    }

    internal func isEqual(to other: Self) -> Bool {
        value == other.value
    }

    internal func isLess(than other: Self) -> Bool {
        value < other.value
    }

    internal func logarithm() -> Self {
        Self(Double.log(value))
    }

    internal func logarithm(base: Self) -> Self {
        Self(Double.log(value) / Double.log(base.value))
    }

    internal func logarithmBase10() -> Self {
        Self(Double.log10(value))
    }

    internal func logarithmBase2() -> Self {
        Self(Double.log2(value))
    }

    internal func multiplied(by other: Self) -> Self {
        Self(value * other.value)
    }

    internal func negated() -> Self {
        Self(-value)
    }

    internal func round() -> Self {
        Self(value.rounded(.toNearestOrEven))
    }

    internal func sine() -> Self {
        Self(Double.sin(value))
    }

    internal func squareRoot() -> Self {
        Self(Double.sqrt(value))
    }

    internal func subtracting(_ other: Self) -> Self {
        Self(value - other.value)
    }

    internal func tangent() -> Self {
        Self(Double.tan(value))
    }

    internal func truncate() -> Self {
        Self(trunc(value))
    }

    // MARK: Private Type Properties

    private static let specials: [String: Double] = ["+inf.0": .infinity,
                                                     "-inf.0": -.infinity,
                                                     "+nan.0": .nan,
                                                     "-nan.0": .nan]

    // MARK: Private Type Methods

    private static func _matchFloatingPoint(input: String) -> String? {
        guard let output = input.wholeMatch(of: Number.fpDecValue)?.output
        else { return nil }

        return String(output)
    }
}

// MARK: - CustomDebugStringConvertible

extension FloatingPoint: CustomDebugStringConvertible {
    internal var debugDescription: String {
        if value.isNaN {
            "floatingPoint<+nan.0>"
        } else if value.isInfinite {
            "floatingPoint<\(value < 0 ? "-" : "+")inf.0>"
        } else if value.isZero {
            "floatingPoint<0.0>"    // just in case -0.0 creeped in
        } else {
            "floatingPoint<\(String(reflecting: value))>"
        }
    }
}

// MARK: - CustomStringConvertible

extension FloatingPoint: CustomStringConvertible {
    internal var description: String {
        if value.isNaN {
            "+nan.0"
        } else if value.isInfinite {
            "\(value < 0 ? "-" : "+")inf.0"
        } else if value.isZero {
            "0.0"                   // just in case -0.0 creeped in
        } else {
            String(describing: value)
        }
    }
}

// MARK: - Sendable

extension FloatingPoint: Sendable {
}
