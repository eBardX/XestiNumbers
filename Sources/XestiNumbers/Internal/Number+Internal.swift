// © 2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Internal Instance Methods

    internal func checkExactInteger(file: StaticString = #file,
                                    line: UInt = #line) -> ExactInteger {
        switch value {
        case let .complex(val) where val.isExact && val.isInteger:
            val.realPart.exactIntegerValue

        case let .real(val) where val.isExact && val.isInteger:
            val.exactIntegerValue

        default:
            fatalError("\(self) must be an exact integer",
                       file: file,
                       line: line)
        }
    }

    internal func checkInteger(file: StaticString = #file,
                               line: UInt = #line) -> Real {
        switch value {
        case let .complex(val) where val.isInteger:
            val.realPart

        case let .real(val) where val.isInteger:
            val

        default:
            fatalError("\(self) must be an integer",
                       file: file,
                       line: line)
        }
    }

    internal func checkRational(file: StaticString = #file,
                                line: UInt = #line) -> Real {
        switch value {
        case let .complex(val) where val.isRational:
            val.realPart

        case let .real(val) where val.isRational:
            val

        default:
            fatalError("\(self) must be a rational number",
                       file: file,
                       line: line)
        }
    }

    internal func checkReal(file: StaticString = #file,
                            line: UInt = #line) -> Real {
        switch value {
        case let .complex(val) where val.isReal:
            val.realPart

        case let .real(val):
            val

        default:
            fatalError("\(self) must be a real number",
                       file: file,
                       line: line)
        }
    }

    internal func toComplex() -> Complex {
        switch value {
        case let .complex(val):
            val

        case let .real(val):
            Complex(realPart: val,
                    imaginaryPart: val.isExact ? .exactZero : .inexactZero)
        }
    }
}
