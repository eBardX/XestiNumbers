// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import BigInt

private import XestiTools

internal struct ExactInteger {

    // MARK: Internal Nested Types

    internal enum Value {
        case large(BigInt)
        case small(Int)
    }

    // MARK: Internal Initializers

    internal init(_ value: Value) {
        self.value = value
    }

    // MARK: Internal Instance Properties

    internal let value: Value
}

// MARK: -

extension ExactInteger {

    // MARK: Internal Type Properties

    internal static let one  = Self(.small(1))
    internal static let zero = Self(.small(0))

    // MARK: Internal Type Methods

    internal static func parse(input: String,
                               radix: Number.Radix) -> Self? {
        let lcText = input.lowercased()

        if let tval = _matchExactInteger(input: lcText,
                                         radix: radix),
           let rval = BigInt(tval,
                             radix: radix.rawValue) {
            return Self(rval)
        }

        return nil
    }

    // MARK: Internal Initializers

    internal init<T: BinaryFloatingPoint>(_ value: T) {
        if let intValue = Int(exactly: value) {
            self.init(.small(intValue))
        } else if let bigIntValue = BigInt(exactly: value) {
            self.init(.large(bigIntValue))
        } else {
            fatalError("\(value) must be an integer")
        }
    }

    internal init<T: BinaryInteger>(_ value: T) {
        if let intValue = Int(exactly: value) {
            self.init(.small(intValue))
        } else {
            self.init(.large(BigInt(value)))
        }
    }

    // MARK: Internal Instance Properties

    internal var floatingPointValue: FloatingPoint {
        switch value {
        case let .large(val):
            FloatingPoint(Double(val))

        case let .small(val):
            FloatingPoint(Double(val))
        }
    }

    @available(iOS 18.0, macOS 15.0, *)
    internal var int128Value: Int128 {
        switch value {
        case let .large(val):
            Int128(val)

        case let .small(val):
            Int128(val)
        }
    }

    internal var int16Value: Int16 {
        switch value {
        case let .large(val):
            Int16(val)

        case let .small(val):
            Int16(val)
        }
    }

    internal var int32Value: Int32 {
        switch value {
        case let .large(val):
            Int32(val)

        case let .small(val):
            Int32(val)
        }
    }

    internal var int64Value: Int64 {
        switch value {
        case let .large(val):
            Int64(val)

        case let .small(val):
            Int64(val)
        }
    }

    internal var int8Value: Int8 {
        switch value {
        case let .large(val):
            Int8(val)

        case let .small(val):
            Int8(val)
        }
    }

    internal var intValue: Int {
        switch value {
        case let .large(val):
            Int(val)

        case let .small(val):
            val
        }
    }

    internal var isEven: Bool {
        switch value {
        case let .large(val):
            (val & 1) == 0

        case let .small(val):
            (val & 1) == 0
        }
    }

    internal var isNegative: Bool {
        switch value {
        case let .large(val):
            val < 0

        case let .small(val):
            val < 0
        }
    }

    internal var isOdd: Bool {
        switch value {
        case let .large(val):
            (val & 1) != 0

        case let .small(val):
            (val & 1) != 0
        }
    }

    internal var isPositive: Bool {
        switch value {
        case let .large(val):
            val > 0

        case let .small(val):
            val > 0
        }
    }

    internal var isZero: Bool {
        switch value {
        case let .large(val):
            val == 0

        case let .small(val):
            val == 0
        }
    }

    @available(iOS 18.0, macOS 15.0, *)
    internal var uint128Value: UInt128 {
        switch value {
        case let .large(val):
            UInt128(val)

        case let .small(val):
            UInt128(val)
        }
    }

    internal var uint16Value: UInt16 {
        switch value {
        case let .large(val):
            UInt16(val)

        case let .small(val):
            UInt16(val)
        }
    }

    internal var uint32Value: UInt32 {
        switch value {
        case let .large(val):
            UInt32(val)

        case let .small(val):
            UInt32(val)
        }
    }

    internal var uint64Value: UInt64 {
        switch value {
        case let .large(val):
            UInt64(val)

        case let .small(val):
            UInt64(val)
        }
    }

    internal var uint8Value: UInt8 {
        switch value {
        case let .large(val):
            UInt8(val)

        case let .small(val):
            UInt8(val)
        }
    }

    internal var uintValue: UInt {
        switch value {
        case let .large(val):
            UInt(val)

        case let .small(val):
            UInt(val)
        }
    }

    // MARK: Internal Instance Methods

    internal func adding(_ other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            return Self(.large(val1 + val2))

        case let (.large(val1), .small(val2)):
            return Self(.large(val1 + BigInt(val2)))

        case let (.small(val1), .large(val2)):
            return Self(.large(BigInt(val1) + val2))

        case let (.small(val1), .small(val2)):
            let result = val1.addingReportingOverflow(val2)

            if result.overflow {
                return Self(.large(BigInt(val1) + BigInt(val2)))
            }

            return Self(.small(result.partialValue))
        }
    }

    internal func bitwiseAnd(with other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            Self(.large(val1 & val2))

        case let (.large(val1), .small(val2)):
            Self(.large(val1 & BigInt(val2)))

        case let (.small(val1), .large(val2)):
            Self(.large(BigInt(val1) & val2))

        case let (.small(val1), .small(val2)):
            Self(.small(val1 & val2))
        }
    }

    internal func bitwiseNot() -> Self {
        switch value {
        case let .large(val):
            Self(.large(~val))

        case let .small(val):
            Self(.small(~val))
        }
    }

    internal func bitwiseOr(with other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            Self(.large(val1 | val2))

        case let (.large(val1), .small(val2)):
            Self(.large(val1 | BigInt(val2)))

        case let (.small(val1), .large(val2)):
            Self(.large(BigInt(val1) | val2))

        case let (.small(val1), .small(val2)):
            Self(.small(val1 | val2))
        }
    }

    internal func bitwiseShiftLeft(bits: Int) -> Self {
        switch value {
        case let .large(val):
            return Self(.large(val << bits))

        case let .small(val):
            if bits > 0 {
                return Self(.large(BigInt(val) << bits))
            }

            return Self(.small(val << bits))  // cannot overflow
        }
    }

    internal func bitwiseShiftRight(bits: Int) -> Self {
        switch value {
        case let .large(val):
            return Self(.large(val >> bits))

        case let .small(val):
            if bits < 0 {
                return Self(.large(BigInt(val) >> bits))
            }

            return Self(.small(val >> bits))  // cannot overflow
        }
    }

    internal func bitwiseXor(with other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            Self(.large(val1 ^ val2))

        case let (.large(val1), .small(val2)):
            Self(.large(val1 ^ BigInt(val2)))

        case let (.small(val1), .large(val2)):
            Self(.large(BigInt(val1) ^ val2))

        case let (.small(val1), .small(val2)):
            Self(.small(val1 ^ val2))
        }
    }

    internal func greatestCommonDivisor(with other: Self) -> Self {
        let n1 = isNegative ? negated() : self
        let n2 = other.isNegative ? other.negated() : other

        switch (n1.value, n2.value) {
        case let (.large(val1), .large(val2)):
            return Self(.large(val1.greatestCommonDivisor(with: val2)))

        case let (.large(val1), .small(val2)):
            return Self(.large(val1.greatestCommonDivisor(with: BigInt(val2))))

        case let (.small(val1), .large(val2)):
            return Self(.large(BigInt(val1).greatestCommonDivisor(with: val2)))

        case let (.small(val1), .small(val2)):
            return Self(.small(Int(UInt.gcd(UInt(val1), UInt(val2)))))
        }
    }

    internal func isEqual(to other: Self) -> Bool {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            val1 == val2

        case let (.large(val1), .small(val2)):
            val1 == BigInt(val2)

        case let (.small(val1), .large(val2)):
            BigInt(val1) == val2

        case let (.small(val1), .small(val2)):
            val1 == val2
        }
    }

    internal func isLess(than other: Self) -> Bool {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            val1 < val2

        case let (.large(val1), .small(val2)):
            val1 < BigInt(val2)

        case let (.small(val1), .large(val2)):
            BigInt(val1) < val2

        case let (.small(val1), .small(val2)):
            val1 < val2
        }
    }

    internal func isMultiple(of other: Self) -> Bool {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            val1.isMultiple(of: val2)

        case let (.large(val1), .small(val2)):
            val1.isMultiple(of: BigInt(val2))

        case let (.small(val1), .large(val2)):
            BigInt(val1).isMultiple(of: val2)

        case let (.small(val1), .small(val2)):
            val1.isMultiple(of: val2)
        }
    }

    internal func leastCommonMultiple(with other: Self) -> Self {
        let n1 = isNegative ? negated() : self
        let n2 = other.isNegative ? other.negated() : other

        return n1.quotient(dividingBy: n1.greatestCommonDivisor(with: n2)).multiplied(by: n2)
    }

    internal func modulo(_ other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            Self(.large(val1.modulus(val2)))

        case let (.large(val1), .small(val2)):
            Self(.large(val1.modulus(BigInt(val2))))

        case let (.small(val1), .large(val2)):
            Self(.large(BigInt(val1).modulus(val2)))

        case let (.small(val1), .small(val2)):
            Self(.small(val1.modulo(val2)))
        }
    }

    internal func multiplied(by other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            return Self(.large(val1 * val2))

        case let (.large(val1), .small(val2)):
            return Self(.large(val1 * BigInt(val2)))

        case let (.small(val1), .large(val2)):
            return Self(.large(BigInt(val1) * val2))

        case let (.small(val1), .small(val2)):
            let result = val1.multipliedReportingOverflow(by: val2)

            if result.overflow {
                return Self(.large(BigInt(val1) * BigInt(val2)))
            }

            return Self(.small(result.partialValue))
        }
    }

    internal func negated() -> Self {
        switch value {
        case let .large(val):
            return Self(.large(-val))

        case let .small(val):
            let result = 0.subtractingReportingOverflow(val)

            if result.overflow {
                return Self(.large(-BigInt(val)))
            }

            return Self(.small(result.partialValue))
        }
    }

    internal func quotient(dividingBy other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            return Self(.large(val1 / val2))

        case let (.large(val1), .small(val2)):
            return Self(.large(val1 / BigInt(val2)))

        case let (.small(val1), .large(val2)):
            return Self(.large(BigInt(val1) / val2))

        case let (.small(val1), .small(val2)):
            let result = val1.dividedReportingOverflow(by: val2)

            if result.overflow {
                return Self(.large(BigInt(val1) / BigInt(val2)))
            }

            return Self(.small(result.partialValue))
        }
    }

    internal func quotientAndRemainder(dividingBy other: Self) -> (quotient: Self, remainder: Self) {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            let (qval, rval) = val1.quotientAndRemainder(dividingBy: val2)

            return (Self(.large(qval)), Self(.large(rval)))

        case let (.large(val1), .small(val2)):
            let (qval, rval) = val1.quotientAndRemainder(dividingBy: BigInt(val2))

            return (Self(.large(qval)), Self(.large(rval)))

        case let (.small(val1), .large(val2)):
            let (qval, rval) = BigInt(val1).quotientAndRemainder(dividingBy: val2)

            return (Self(.large(qval)), Self(.large(rval)))

        case let (.small(val1), .small(val2)):
            let (qval, rval) = val1.quotientAndRemainder(dividingBy: val2)

            return (Self(.small(qval)), Self(.small(rval)))
        }
    }

    internal func remainder(dividingBy other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            Self(.large(val1 % val2))

        case let (.large(val1), .small(val2)):
            Self(.large(val1 % BigInt(val2)))

        case let (.small(val1), .large(val2)):
            Self(.large(BigInt(val1) % val2))

        case let (.small(val1), .small(val2)):
            Self(.small(val1 % val2))
        }
    }

    internal func subtracting(_ other: Self) -> Self {
        switch (value, other.value) {
        case let (.large(val1), .large(val2)):
            return Self(.large(val1 - val2))

        case let (.large(val1), .small(val2)):
            return Self(.large(val1 - BigInt(val2)))

        case let (.small(val1), .large(val2)):
            return Self(.large(BigInt(val1) - val2))

        case let (.small(val1), .small(val2)):
            let result = val1.subtractingReportingOverflow(val2)

            if result.overflow {
                return Self(.large(BigInt(val1) - BigInt(val2)))
            }

            return Self(.small(result.partialValue))
        }
    }

    // MARK: Private Type Methods

    private static func _matchExactInteger(input: String,
                                           radix: Number.Radix) -> String? {
        let match = switch radix {
        case .binary:
            input.wholeMatch(of: Number.eiBinValue)

        case .decimal:
            input.wholeMatch(of: Number.eiDecValue)

        case .hexadecimal:
            input.wholeMatch(of: Number.eiHexValue)

        case .octal:
            input.wholeMatch(of: Number.eiOctValue)
        }

        guard let output = match?.output
        else { return nil }

        return String(output)
    }
}

// MARK: - CustomDebugStringConvertible

extension ExactInteger: CustomDebugStringConvertible {
    internal var debugDescription: String {
        switch value {
        case let .large(val):
            "large<\(String(reflecting: val))>"

        case let .small(val):
            "small<\(String(reflecting: val))>"
        }
    }
}

// MARK: - CustomStringConvertible

extension ExactInteger: CustomStringConvertible {
    internal var description: String {
        switch value {
        case let .large(val):
            String(describing: val)

        case let .small(val):
            String(describing: val)
        }
    }
}

// MARK: - Sendable

extension ExactInteger: Sendable {
}
