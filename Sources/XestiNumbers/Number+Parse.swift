// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Type Methods

    /// Parses the provided input string into a number.
    ///
    /// The input string is parsed in accordance with the number syntax defined
    /// in § 7.1.1 of the [Revised⁷ Report on the Algorithmic Language
    /// Scheme](https://small.r7rs.org/attachment/r7rs.pdf).
    ///
    /// - Parameter input:  The input string to parse.
    ///
    /// - Returns:  The parsed number on success, or `nil` on failure.
    public static func parse<S: StringProtocol>(input: S) -> Self? {
        guard let (text, radix, exactness) = _matchPrefixes(input: String(input))
        else { return nil }

        return parse(input: text,
                     radix: radix,
                     exactness: exactness)
    }

    // MARK: Internal Type Methods

    internal static func parse<S: StringProtocol>(input: S,
                                                  radix: Radix,
                                                  exactness: Exactness) -> Self? {
        guard let value = _parseNumber(input: String(input),
                                       radix: radix,
                                       exactness: exactness)
        else { return nil }

        return value
    }

    // MARK: Private Type Properties

    private static let exactnesses: [String: Exactness] = ["#e": .exact,
                                                           "#i": .inexact]

    private static let radixes: [String: Radix] = ["#b": .binary,
                                                   "#d": .decimal,
                                                   "#o": .octal,
                                                   "#x": .hexadecimal]

    // MARK: Private Type Methods

    private static func _matchPrefixes(input: String) -> (String, Radix, Exactness)? {
        var exactness: Exactness?
        var radix: Radix?
        var text = input

        while !text.isEmpty, radix == nil || exactness == nil {
            if let prefix = text.prefixMatch(of: Self.pfxRadix)?.output,
               let tmpRadix = Self.radixes[String(prefix)] {
                guard radix == nil      // should be (at most) a single radix prefix
                else { return nil }

                radix = tmpRadix
                text = String(text.dropFirst(2))

                continue    // check for another prefix
            }

            if let prefix = text.prefixMatch(of: Self.pfxExactness)?.output,
               let tmpExactness = Self.exactnesses[String(prefix)] {
                guard exactness == nil  // should be (at most) a single exactness prefix
                else { return nil }

                exactness = tmpExactness
                text = String(text.dropFirst(2))

                continue    // check for another prefix
            }

            break   // no more prefixes
        }

        return (text, radix ?? .decimal, exactness ?? .unspecified)
    }

    private static func _parseNumber(input: String,
                                     radix: Radix,
                                     exactness: Exactness) -> Self? {
        if let rval = Complex.parse(input: input,
                                    radix: radix,
                                    exactness: exactness) {
            return Self(.complex(rval))
        }

        if let rval = Real.parse(input: input,
                                 radix: radix,
                                 exactness: exactness) {
            return Self(.real(rval))
        }

        return nil
    }
}
