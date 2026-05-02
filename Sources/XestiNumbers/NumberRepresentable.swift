// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A type that can be represented by a number value.
///
/// With a `NumberRepresentable` type, you can losslessly convert back and forth
/// between a custom type and a number value.
///
/// In addition, you can restrict the number values that are considered valid
/// representations of your custom type.
///
/// Using the number value of a conforming type simplifies conformance to other
/// protocols, such as `Codable`, `Comparable`, and `Hashable`.
public protocol NumberRepresentable: Codable,
                                     Comparable,
                                     CustomDebugStringConvertible,
                                     CustomStringConvertible,
                                     Equatable,
                                     ExpressibleByFloatLiteral,
                                     ExpressibleByIntegerLiteral,
                                     ExpressibleByStringLiteral,
                                     Hashable,
                                     Sendable {
    /// Determines if the provided number value is a valid representation for
    /// this type.
    ///
    /// The default implementation considers _any_ number value to be valid.
    ///
    /// - Parameter numberValue:    The number value to check for validity.
    ///
    /// - Returns:  `true` when the provided number value is a valid
    ///             representation for this type; `false` otherwise.
    static func isValid(_ numberValue: Number) -> Bool

    /// Creates a new instance with the provided number value.
    ///
    /// If the provided number value is determined to be invalid, this
    /// initializer stops execution.
    ///
    /// The default implementation is sufficient in most cases.
    ///
    /// - Parameter numberValue:    The number value to use for the new
    ///                             instance.
    init(_ numberValue: Number)

    /// Creates a new instance with the provided number value.
    ///
    /// If the provided number value is determined to be invalid, this
    /// initializer returns `nil`.
    ///
    /// Typically, this initializer can be implemented as follows:
    ///
    /// ```swift
    /// public init?(numberValue: Number) {
    ///     guard Self.isValid(numberValue)
    ///     else { return nil }
    ///
    ///     self.numberValue = numberValue
    /// }
    /// ```
    ///
    /// - Parameter numberValue:    The number value to use for the new
    ///                             instance.
    init?(numberValue: Number)

    /// The number value converted to a `Double` value.
    var doubleValue: Double { get }

    /// The number value converted to a `Float` value.
    var floatValue: Float { get }

    /// The number value converted to an `Int128` value.
    @available(iOS 18.0, macOS 15.0, *)
    var int128Value: Int128 { get }

    /// The number value converted to an `Int16` value.
    var int16Value: Int16 { get }

    /// The number value converted to an `Int32` value.
    var int32Value: Int32 { get }

    /// The number value converted to an `Int64` value.
    var int64Value: Int64 { get }

    /// The number value converted to an `Int8` value.
    var int8Value: Int8 { get }

    /// The number value converted to an `Int` value.
    var intValue: Int { get }

    /// The number value that represents this type.
    var numberValue: Number { get }

    /// The number value converted to a `UInt128` value.
    @available(iOS 18.0, macOS 15.0, *)
    var uint128Value: UInt128 { get }

    /// The number value converted to a `UInt16` value.
    var uint16Value: UInt16 { get }

    /// The number value converted to a `UInt32` value.
    var uint32Value: UInt32 { get }

    /// The number value converted to a `UInt64` value.
    var uint64Value: UInt64 { get }

    /// The number value converted to a `UInt8` value.
    var uint8Value: UInt8 { get }

    /// The number value converted to a `UInt` value.
    var uintValue: UInt { get }
}

// MARK: - (defaults)

extension NumberRepresentable {

    // MARK: Public Type Methods

    public static func isValid(_ numberValue: Number) -> Bool {
        true
    }

    // MARK: Public Initializers

    public init(_ numberValue: Number) {
        self.init(numberValue: numberValue)!    // swiftlint:disable:this force_unwrapping
    }

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        numberValue.doubleValue
    }

    public var floatValue: Float {
        numberValue.floatValue
    }

    @available(iOS 18.0, macOS 15.0, *)
    public var int128Value: Int128 {
        numberValue.int128Value
    }

    public var int16Value: Int16 {
        numberValue.int16Value
    }

    public var int32Value: Int32 {
        numberValue.int32Value
    }

    public var int64Value: Int64 {
        numberValue.int64Value
    }

    public var int8Value: Int8 {
        numberValue.int8Value
    }

    public var intValue: Int {
        numberValue.intValue
    }

    @available(iOS 18.0, macOS 15.0, *)
    public var uint128Value: UInt128 {
        numberValue.uint128Value
    }

    public var uint16Value: UInt16 {
        numberValue.uint16Value
    }

    public var uint32Value: UInt32 {
        numberValue.uint32Value
    }

    public var uint64Value: UInt64 {
        numberValue.uint64Value
    }

    public var uint8Value: UInt8 {
        numberValue.uint8Value
    }

    public var uintValue: UInt {
        numberValue.uintValue
    }
}

// MARK: - Codable

extension NumberRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let numberValue = try container.decode(Number.self)

        self.init(numberValue: numberValue)!    // swiftlint:disable:this force_unwrapping
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(numberValue)
    }
}

// MARK: - Comparable

extension NumberRepresentable where Self: Comparable {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.numberValue < rhs.numberValue
    }
}

// MARK: - CustomDebugStringConvertible

extension NumberRepresentable where Self: CustomDebugStringConvertible {
    public var debugDescription: String {
        String(reflecting: numberValue)
    }
}

// MARK: - CustomStringConvertible

extension NumberRepresentable where Self: CustomStringConvertible {
    public var description: String {
        String(describing: numberValue)
    }
}

// MARK: - Equatable

extension NumberRepresentable where Self: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.numberValue == rhs.numberValue
    }
}

// MARK: - ExpressibleByFloatLiteral

extension NumberRepresentable where Self: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(numberValue: Number(floatLiteral: value))!    // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension NumberRepresentable where Self: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self.init(numberValue: Number(integerLiteral: value))!  // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - ExpressibleByStringLiteral

extension NumberRepresentable where Self: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(numberValue: Number(stringLiteral: value))!   // swiftlint:disable:this force_unwrapping
    }
}
