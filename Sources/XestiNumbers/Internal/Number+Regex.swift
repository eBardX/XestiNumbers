// © 2025–2026 John Gary Pusey (see LICENSE.md)

@preconcurrency import RegexBuilder

extension Number {

    // MARK: Internal Type Properties

    internal nonisolated(unsafe) static let cxBinValueP = Regex {
        Capture {
            binReal
        }
        "@"
        Capture {
            binReal
        }
    }

    internal nonisolated(unsafe) static let cxBinValueR = Regex {
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

    internal nonisolated(unsafe) static let cxDecValueP = Regex {
        Capture {
            decReal
        }
        "@"
        Capture {
            decReal
        }
    }

    internal nonisolated(unsafe) static let cxDecValueR = Regex {
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

    internal nonisolated(unsafe) static let cxHexValueP = Regex {
        Capture {
            hexReal
        }
        "@"
        Capture {
            hexReal
        }
    }

    internal nonisolated(unsafe) static let cxHexValueR = Regex {
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

    internal nonisolated(unsafe) static let cxOctValueP = Regex {
        Capture {
            octReal
        }
        "@"
        Capture {
            octReal
        }
    }

    internal nonisolated(unsafe) static let cxOctValueR = Regex {
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

    internal nonisolated(unsafe) static let eiBinValue = Regex {
        Optionally {
            sign
        }
        binUInteger
    }

    internal nonisolated(unsafe) static let eiDecValue = Regex {
        Optionally {
            sign
        }
        decUInteger
    }

    internal nonisolated(unsafe) static let eiHexValue = Regex {
        Optionally {
            sign
        }
        hexUInteger
    }

    internal nonisolated(unsafe) static let eiOctValue = Regex {
        Optionally {
            sign
        }
        octUInteger
    }

    internal nonisolated(unsafe) static let fpDecValue = Regex {
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

    internal nonisolated(unsafe) static let fracBinValue = Regex {
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

    internal nonisolated(unsafe) static let fracDecValue = Regex {
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

    internal nonisolated(unsafe) static let fracHexValue = Regex {
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

    internal nonisolated(unsafe) static let fracOctValue = Regex {
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

    internal nonisolated(unsafe) static let pfxExactness = Regex {
        "#"
        exactness
    }

    internal nonisolated(unsafe) static let pfxRadix = Regex {
        "#"
        radix
    }

    // MARK: Private Type Properties

    private nonisolated(unsafe) static let binReal = Regex {
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

    private nonisolated(unsafe) static let decReal = Regex {
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

    private nonisolated(unsafe) static let hexReal = Regex {
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

    private nonisolated(unsafe) static let octReal = Regex {
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

    private nonisolated(unsafe) static let binUReal = Regex {
        binUInteger
        Optionally {
            "/"
            binUInteger
        }
    }

    private nonisolated(unsafe) static let decUReal = Regex {
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

    private nonisolated(unsafe) static let hexUReal = Regex {
        hexUInteger
        Optionally {
            "/"
            hexUInteger
        }
    }

    private nonisolated(unsafe) static let octUReal = Regex {
        octUInteger
        Optionally {
            "/"
            octUInteger
        }
    }

    private nonisolated(unsafe) static let decSuffix = Regex {
        "e"
        Optionally {
            sign
        }
        decUInteger
    }

    private nonisolated(unsafe) static let decUFloat = Regex {
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

    private nonisolated(unsafe) static let binUInteger = Regex {
        OneOrMore {
            binDigit
        }
    }

    private nonisolated(unsafe) static let decUInteger = Regex {
        OneOrMore {
            decDigit
        }
    }

    private nonisolated(unsafe) static let hexUInteger = Regex {
        OneOrMore {
            hexDigit
        }
    }

    private nonisolated(unsafe) static let octUInteger = Regex {
        OneOrMore {
            octDigit
        }
    }

    private nonisolated(unsafe) static let special = Regex {
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
