// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiNumbers

struct NumberRegexTests {
}

// MARK: -

extension NumberRegexTests {
    @Test
    func cxBinValueP() {
        #expect("101@11".wholeMatch(of: Number.cxBinValueP) != nil)
        #expect("101+11i".wholeMatch(of: Number.cxBinValueP) == nil)
    }

    @Test
    func cxBinValueR() {
        #expect("101+11i".wholeMatch(of: Number.cxBinValueR) != nil)
        #expect("+11i".wholeMatch(of: Number.cxBinValueR) != nil)
        #expect("101@11".wholeMatch(of: Number.cxBinValueR) == nil)
    }

    @Test
    func cxDecValueP() {
        #expect("3@4".wholeMatch(of: Number.cxDecValueP) != nil)
        #expect("-3.5@2".wholeMatch(of: Number.cxDecValueP) != nil)
        #expect("3+4i".wholeMatch(of: Number.cxDecValueP) == nil)
    }

    @Test
    func cxDecValueR() {
        #expect("3+4i".wholeMatch(of: Number.cxDecValueR) != nil)
        #expect("-4i".wholeMatch(of: Number.cxDecValueR) != nil)
        #expect("3@4".wholeMatch(of: Number.cxDecValueR) == nil)
    }

    @Test
    func cxHexValueP() {
        #expect("2a@ff".wholeMatch(of: Number.cxHexValueP) != nil)
        #expect("2a+ffi".wholeMatch(of: Number.cxHexValueP) == nil)
    }

    @Test
    func cxHexValueR() {
        #expect("2a+ffi".wholeMatch(of: Number.cxHexValueR) != nil)
        #expect("2a@ff".wholeMatch(of: Number.cxHexValueR) == nil)
    }

    @Test
    func cxOctValueP() {
        #expect("52@17".wholeMatch(of: Number.cxOctValueP) != nil)
        #expect("52+17i".wholeMatch(of: Number.cxOctValueP) == nil)
    }

    @Test
    func cxOctValueR() {
        #expect("52+17i".wholeMatch(of: Number.cxOctValueR) != nil)
        #expect("52@17".wholeMatch(of: Number.cxOctValueR) == nil)
    }

    @Test
    func eiBinValue() {
        #expect("101010".wholeMatch(of: Number.eiBinValue) != nil)
        #expect("-101".wholeMatch(of: Number.eiBinValue) != nil)
        #expect("2".wholeMatch(of: Number.eiBinValue) == nil)
    }

    @Test
    func eiDecValue() {
        #expect("42".wholeMatch(of: Number.eiDecValue) != nil)
        #expect("-7".wholeMatch(of: Number.eiDecValue) != nil)
        #expect("4a".wholeMatch(of: Number.eiDecValue) == nil)
    }

    @Test
    func eiHexValue() {
        #expect("2a".wholeMatch(of: Number.eiHexValue) != nil)
        #expect("-ff".wholeMatch(of: Number.eiHexValue) != nil)
        #expect("gg".wholeMatch(of: Number.eiHexValue) == nil)
    }

    @Test
    func eiOctValue() {
        #expect("52".wholeMatch(of: Number.eiOctValue) != nil)
        #expect("-17".wholeMatch(of: Number.eiOctValue) != nil)
        #expect("8".wholeMatch(of: Number.eiOctValue) == nil)
    }

    @Test
    func fpDecValue() {
        #expect("3.14".wholeMatch(of: Number.fpDecValue) != nil)
        #expect("+inf.0".wholeMatch(of: Number.fpDecValue) != nil)
        #expect("42".wholeMatch(of: Number.fpDecValue) == nil)
    }

    @Test
    func fracBinValue() {
        #expect("101/11".wholeMatch(of: Number.fracBinValue) != nil)
        #expect("101".wholeMatch(of: Number.fracBinValue) == nil)
        #expect("2/1".wholeMatch(of: Number.fracBinValue) == nil)
    }

    @Test
    func fracDecValue() {
        #expect("3/4".wholeMatch(of: Number.fracDecValue) != nil)
        #expect("-3/4".wholeMatch(of: Number.fracDecValue) != nil)
        #expect("3.4/2".wholeMatch(of: Number.fracDecValue) == nil)
    }

    @Test
    func fracHexValue() {
        #expect("2a/ff".wholeMatch(of: Number.fracHexValue) != nil)
        #expect("2a".wholeMatch(of: Number.fracHexValue) == nil)
    }

    @Test
    func fracOctValue() {
        #expect("52/17".wholeMatch(of: Number.fracOctValue) != nil)
        #expect("8/1".wholeMatch(of: Number.fracOctValue) == nil)
    }

    @Test
    func pfxExactness() {
        #expect(String("#e42".prefixMatch(of: Number.pfxExactness)?.output ?? "") == "#e")
        #expect(String("#i42".prefixMatch(of: Number.pfxExactness)?.output ?? "") == "#i")
        #expect("42".prefixMatch(of: Number.pfxExactness) == nil)
    }

    @Test
    func pfxRadix() {
        #expect(String("#b101".prefixMatch(of: Number.pfxRadix)?.output ?? "") == "#b")
        #expect(String("#x2a".prefixMatch(of: Number.pfxRadix)?.output ?? "") == "#x")
        #expect("42".prefixMatch(of: Number.pfxRadix) == nil)
    }
}
