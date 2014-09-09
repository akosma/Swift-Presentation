import Foundation

infix operator .... {}

func .... (lhs: Int, rhs: Int) -> Range<Int> {
    return Range(start: Int(arc4random_uniform(UInt32(lhs))),
                 end: Int(arc4random_uniform(UInt32(rhs))))
}

44....100
67....453
