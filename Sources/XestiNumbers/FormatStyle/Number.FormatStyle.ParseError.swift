// © 2026 John Gary Pusey (see LICENSE.md)

extension Number.FormatStyle {

    // MARK: Public Nested Types

    /// An error thrown when ``Number/FormatStyle/ParseStrategy`` fails to
    /// parse an input string.
    public struct ParseError {

        // MARK: Public Instance Properties

        /// The input string that could not be parsed.
        public let input: String
    }
}

// MARK: - CustomStringConvertible

extension Number.FormatStyle.ParseError: CustomStringConvertible {
    public var description: String {
        "invalid number: \"\(input)\""
    }
}

// MARK: - Equatable

extension Number.FormatStyle.ParseError: Equatable {
}

// MARK: - Error

extension Number.FormatStyle.ParseError: Error {
}

// MARK: - Sendable

extension Number.FormatStyle.ParseError: Sendable {
}
