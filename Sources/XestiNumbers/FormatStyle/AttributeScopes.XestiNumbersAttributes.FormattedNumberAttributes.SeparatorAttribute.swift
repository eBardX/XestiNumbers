// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension AttributeScopes.XestiNumbersAttributes.FormattedNumberAttributes {

    // MARK: Public Nested Types

    /// An attributed string attribute that identifies the kind of separator
    /// character applied to a run of text in a number formatted by
    /// ``Number/FormatStyle``.
    public enum SeparatorAttribute: CodableAttributedStringKey {
        /// The name used to identify this attribute.
        public static let name = "XestiNumbers.Separator"
    }
}
