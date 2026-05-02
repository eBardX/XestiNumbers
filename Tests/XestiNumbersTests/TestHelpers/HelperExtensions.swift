// © 2026 John Gary Pusey (see LICENSE.md)

@testable import XestiNumbers

extension Complex {
    internal func testEqual(to other: Self) -> Bool {
        if isInexact || other.isInexact {
            let rval1 = realPart.floatingPointValue.doubleValue
            let rval2 = other.realPart.floatingPointValue.doubleValue
            let ival1 = imaginaryPart.floatingPointValue.doubleValue
            let ival2 = other.imaginaryPart.floatingPointValue.doubleValue

            return rval1.isApproximatelyEqual(to: rval2) && ival1.isApproximatelyEqual(to: ival2)
        } else {
            let rval1 = realPart
            let rval2 = other.realPart
            let ival1 = imaginaryPart
            let ival2 = other.imaginaryPart

            return rval1.isEqual(to: rval2) && ival1.isEqual(to: ival2)
        }
    }
}
extension Double {
    internal func isApproximatelyEqual(to other: Self,
                                       tolerance: Self = 1e-10) -> Bool {
        Swift.abs(self - other) < tolerance
    }
}

extension FloatingPoint {
    internal func testEqual(to other: Self) -> Bool {
        doubleValue.isApproximatelyEqual(to: other.doubleValue)
    }
}
