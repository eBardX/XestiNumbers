// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A generalized numeric value that supports a “number tower” patterned after
/// that in the Scheme programming language.
///
/// As in Scheme, this type supports the following number tower:
///
/// - number
/// - complex
/// - real
/// - rational
/// - integer
///
/// It also supports the Scheme notion of “exactness”.
public struct Number {

    // MARK: Internal Initializers

    internal init(_ value: Value) {
        self.value = value
    }

    // MARK: Internal Instance Properties

    internal let value: Value
}

// MARK: - Codable

extension Number: Codable {
    /// Creates a number by decoding from the provided decoder.
    ///
    /// - Parameter decoder:    The decoder to read from.
    ///
    /// - Throws:   `DecodingError.dataCorruptedError` if the decoded value is
    ///             not a valid number.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        guard let numberValue = Self.parse(input: stringValue)
        else { throw DecodingError.dataCorruptedError(in: container,
                                                      debugDescription: "Invalid number value") }

        self = numberValue
    }

    /// Encodes this number into the provided encoder.
    ///
    /// - Parameter encoder:    The encoder to write to.
    ///
    /// - Throws:   Any error thrown by the encoder.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(String(describing: self))
    }
}

// MARK: - Comparable

extension Number: Comparable {
    /// Returns a Boolean value indicating whether the first number is less than
    /// the second.
    ///
    /// - Warning:  This operation is only defined for real numbers. Both
    ///             operands must be real numbers; applying this operation to
    ///             complex numbers with nonzero imaginary parts will result in
    ///             a fatal error.
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.checkReal().isLess(than: rhs.checkReal())
    }
}

// MARK: - CustomDebugStringConvertible

extension Number: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch value {
        case let .complex(val):
            String(reflecting: val)

        case let .real(val):
            String(reflecting: val)
        }
    }
}

// MARK: - CustomStringConvertible

extension Number: CustomStringConvertible {
    public var description: String {
        switch value {
        case let .complex(val):
            String(describing: val)

        case let .real(val):
            String(describing: val)
        }
    }
}

// MARK: - Equatable

extension Number: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        switch (lhs.value, rhs.value) {
        case let (.complex(val1), .complex(val2)):
            val1.isEqual(to: val2)

        case let (.real(val1), .real(val2)):
            val1.isEqual(to: val2)

        default:
            lhs.toComplex().isEqual(to: rhs.toComplex())
        }
    }
}

// MARK: - ExpressibleByFloatLiteral

extension Number: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension Number: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self.init(value)
    }
}

// MARK: - ExpressibleByStringLiteral

extension Number: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)!   // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Hashable

extension Number: Hashable {
    /// - Note: Because `Number` emulates a Scheme number tower, the `Equatable`
    ///         conformance compares across internal representations (for
    ///         example, exact integer `1` equals inexact `1.0`). This can cause
    ///         equal values to produce different hash values, violating the
    ///         `Hashable` contract. Use caution when using `Number` values as
    ///         dictionary keys or set members if mixing exact and inexact
    ///         representations.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: self))
    }
}

// MARK: - Sendable

extension Number: Sendable {
}
