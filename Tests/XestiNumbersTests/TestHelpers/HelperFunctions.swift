// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
@testable import XestiNumbers

// swiftlint:disable:next static_operator
internal func + (_ val1: AttributedString,
                 _ val2: String) -> AttributedString {
    val1 + AttributedString(val2)
}

// swiftlint:disable:next static_operator
internal func + (_ val1: String,
                 _ val2: AttributedString) -> AttributedString {
    AttributedString(val1) + val2
}

internal func cx<T: BinaryInteger>(_ rval: T,
                                   _ ival: T) -> Complex {
    Complex(realPart: Real(rval),
            imaginaryPart: Real(ival))
}

internal func cx<T: BinaryFloatingPoint>(_ rval: T,
                                         _ ival: T) -> Complex {
    Complex(realPart: Real(rval),
            imaginaryPart: Real(ival))
}

internal func cx(_ rval: Fraction,
                 _ ival: Fraction) -> Complex {
    Complex(realPart: Real(numerator: rval.numerator,
                           denominator: rval.denominator),
            imaginaryPart: Real(numerator: ival.numerator,
                                denominator: ival.denominator))
}

internal func ei<T: BinaryInteger>(_ val: T) -> ExactInteger {
    ExactInteger(val)
}

internal func fp<T: BinaryFloatingPoint>(_ val: T) -> FloatingPoint {
    FloatingPoint(val)
}

internal func fr<T: BinaryInteger>(_ num: T,
                                   _ den: T) -> Fraction {
    Fraction(numerator: ei(num),
             denominator: ei(den))
}

internal func mas(_ val: AttributedString,
                  _ attr: AttributeContainer) -> AttributedString {
    val.mergingAttributes(attr)
}

internal func mas(_ val: String,
                  _ attr: AttributeContainer) -> AttributedString {
    AttributedString(val,
                     attributes: attr)
}

internal func ncx(_ rp: Number,
                  _ ip: Number) -> Number {
    Number(realPart: rp,
           imaginaryPart: ip)
}

internal func nfr(_ num: Number,
                  _ den: Number) -> Number {
    Number(numerator: num,
           denominator: den)
}

internal func rei<T: BinaryInteger>(_ val: T) -> Real {
    Real(.exactInteger(ei(val)))
}

internal func rfp<T: BinaryFloatingPoint>(_ val: T) -> Real {
    Real(.floatingPoint(fp(val)))
}

internal func rfr<T: BinaryInteger>(_ num: T,
                                    _ den: T) -> Real {
    Real(.fraction(fr(num, den)))
}
