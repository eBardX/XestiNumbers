// © 2025–2026 John Gary Pusey (see LICENSE.md)

@preconcurrency import RegexBuilder

extension Number {

    // MARK: Internal Type Properties

    nonisolated(unsafe) internal static let cxBinValueP = Regex {
        Capture {
            binReal
        }
        "@"
        Capture {
            binReal
        }
    }

    nonisolated(unsafe) internal static let cxBinValueR = Regex {
        Capture {
            Optionally {
                binReal
            }
        }
        Capture {
            sign
            Optionally {
                ChoiceOf {
                    binUReal
                    special
                }
            }
        }
        "i"
    }

    nonisolated(unsafe) internal static let cxDecValueP = Regex {
        Capture {
            decReal
        }
        "@"
        Capture {
            decReal
        }
    }

    nonisolated(unsafe) internal static let cxDecValueR = Regex {
        Capture {
            Optionally {
                decReal
            }
        }
        Capture {
            sign
            Optionally {
                ChoiceOf {
                    decUReal
                    special
                }
            }
        }
        "i"
    }

    nonisolated(unsafe) internal static let cxHexValueP = Regex {
        Capture {
            hexReal
        }
        "@"
        Capture {
            hexReal
        }
    }

    nonisolated(unsafe) internal static let cxHexValueR = Regex {
        Capture {
            Optionally {
                hexReal
            }
        }
        Capture {
            sign
            Optionally {
                ChoiceOf {
                    hexUReal
                    special
                }
            }
        }
        "i"
    }

    nonisolated(unsafe) internal static let cxOctValueP = Regex {
        Capture {
            octReal
        }
        "@"
        Capture {
            octReal
        }
    }

    nonisolated(unsafe) internal static let cxOctValueR = Regex {
        Capture {
            Optionally {
                octReal
            }
        }
        Capture {
            sign
            Optionally {
                ChoiceOf {
                    octUReal
                    special
                }
            }
        }
        "i"
    }

    nonisolated(unsafe) internal static let eiBinValue = Regex {
        Optionally {
            sign
        }
        binUInteger
    }

    nonisolated(unsafe) internal static let eiDecValue = Regex {
        Optionally {
            sign
        }
        decUInteger
    }

    nonisolated(unsafe) internal static let eiHexValue = Regex {
        Optionally {
            sign
        }
        hexUInteger
    }

    nonisolated(unsafe) internal static let eiOctValue = Regex {
        Optionally {
            sign
        }
        octUInteger
    }

    nonisolated(unsafe) internal static let fpDecValue = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                decUFloat
            }
            Regex {
                sign
                special
            }
        }
    }

    nonisolated(unsafe) internal static let fracBinValue = Regex {
        Capture {
            Optionally {
                sign
            }
            binUInteger
        }
        "/"
        Capture {
            binUInteger
        }
    }

    nonisolated(unsafe) internal static let fracDecValue = Regex {
        Capture {
            Optionally {
                sign
            }
            decUInteger
        }
        "/"
        Capture {
            decUInteger
        }
    }

    nonisolated(unsafe) internal static let fracHexValue = Regex {
        Capture {
            Optionally {
                sign
            }
            hexUInteger
        }
        "/"
        Capture {
            hexUInteger
        }
    }

    nonisolated(unsafe) internal static let fracOctValue = Regex {
        Capture {
            Optionally {
                sign
            }
            octUInteger
        }
        "/"
        Capture {
            octUInteger
        }
    }

    nonisolated(unsafe) internal static let pfxExactness = Regex {
        "#"
        exactness
    }

    nonisolated(unsafe) internal static let pfxRadix = Regex {
        "#"
        radix
    }

    // MARK: Private Type Properties

    nonisolated(unsafe) private static let binReal = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                binUReal
            }
            Regex {
                sign
                special
            }
        }
    }

    nonisolated(unsafe) private static let decReal = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                decUReal
            }
            Regex {
                sign
                special
            }
        }
    }

    nonisolated(unsafe) private static let hexReal = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                hexUReal
            }
            Regex {
                sign
                special
            }
        }
    }

    nonisolated(unsafe) private static let octReal = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                octUReal
            }
            Regex {
                sign
                special
            }
        }
    }

    nonisolated(unsafe) private static let binUReal = Regex {
        binUInteger
        Optionally {
            "/"
            binUInteger
        }
    }

    nonisolated(unsafe) private static let decUReal = Regex {
        ChoiceOf {
            Regex {
                decUInteger
                Optionally {
                    "/"
                    decUInteger
                }
            }
            decUFloat
        }
    }

    nonisolated(unsafe) private static let hexUReal = Regex {
        hexUInteger
        Optionally {
            "/"
            hexUInteger
        }
    }

    nonisolated(unsafe) private static let octUReal = Regex {
        octUInteger
        Optionally {
            "/"
            octUInteger
        }
    }

    nonisolated(unsafe) private static let decSuffix = Regex {
        "e"
        Optionally {
            sign
        }
        decUInteger
    }

    nonisolated(unsafe) private static let decUFloat = Regex {
        ChoiceOf {
            Regex {
                ChoiceOf {
                    Regex {
                        "."
                        decUInteger
                    }
                    Regex {
                        decUInteger
                        "."
                        Optionally {
                            decUInteger
                        }
                    }
                }
                Optionally {
                    decSuffix
                }
            }
            Regex {
                decUInteger
                decSuffix
            }
        }
    }

    nonisolated(unsafe) private static let binUInteger = Regex {
        OneOrMore {
            binDigit
        }
    }

    nonisolated(unsafe) private static let decUInteger = Regex {
        OneOrMore {
            decDigit
        }
    }

    nonisolated(unsafe) private static let hexUInteger = Regex {
        OneOrMore {
            hexDigit
        }
    }

    nonisolated(unsafe) private static let octUInteger = Regex {
        OneOrMore {
            octDigit
        }
    }

    nonisolated(unsafe) private static let special = Regex {
        ChoiceOf {
            "inf"
            "nan"
        }
        ".0"
    }

    private static let binDigit: CharacterClass  = .anyOf("01")
    private static let decDigit: CharacterClass  = .anyOf("0123456789")
    private static let exactness: CharacterClass = .anyOf("ei")
    private static let hexDigit: CharacterClass  = .anyOf("0123456789abcdef")
    private static let octDigit: CharacterClass  = .anyOf("01234567")
    private static let radix: CharacterClass     = .anyOf("bdox")
    private static let sign: CharacterClass      = .anyOf("+-")
}
