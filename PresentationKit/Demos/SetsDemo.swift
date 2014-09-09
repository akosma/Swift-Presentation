import Foundation

// The empty set
let Ø = NSSet()

// The "Universal" set
let U = NSMutableSet()

// Creation operators
// Every time a new set is created, we add its contents to the
// universal set created above
prefix operator ⟨ {}
prefix func ⟨ (array: [AnyObject]) -> NSSet {
    U.addObjectsFromArray(array)
    return NSSet(array: array)
}

postfix operator ⟩ {}
postfix func ⟩ (array: [AnyObject]) -> [AnyObject] {
    return array
}

// Intersection
infix operator ∩ { associativity left precedence 150 }
func ∩ (s1: NSSet, s2: NSSet) -> NSSet {
    var mutable = NSMutableSet(set: s1)
    mutable.intersectSet(s2)
    return mutable
}

// Union
infix operator ∪ { associativity left precedence 140 }
func ∪ (s1: NSSet, s2: NSSet) -> NSSet {
    return s1.setByAddingObjectsFromSet(s2)
}

// Belongs
infix operator ∈ {}
func ∈ (obj: AnyObject, set: NSSet) -> Bool {
    return set.containsObject(obj)
}

// Relative complement
infix operator ∖ { associativity left precedence 140 }
func ∖ (s1: NSSet, s2: NSSet) -> NSSet {
    var mutable = NSMutableSet(set: s1)
    for obj in s2 {
        mutable.removeObject(obj)
    }
    return mutable
}

// Absolute complement
postfix operator ′ {}
postfix func ′ (set: NSSet) -> NSSet {
    return U ∖ set
}

// Equality
func == (s1: NSSet, s2: NSSet) -> Bool {
    return s1.isEqualToSet(s2)
}

public class SetsDemo: BaseDemo {
    
    override public var description : String {
        return "This demo shows how to use custom operators on Cocoa types to create a simple implementation of basic set operations."
    }
    
    public override var URL : NSURL {
        return NSURL(string: "https://en.wikipedia.org/wiki/Set_(mathematics)")
    }
    
    public override func show() {
        let A = ⟨[1, "alpha", "beta", "gamma", 23, 23]⟩
        let B = ⟨["omega", "gamma", "delta", 23, 63, 1, 1, 1]⟩
        let D = ⟨["Brazil", "Switzerland", "Austria"]⟩
        
        let intersection = A ∩ B
        let union = A ∪ B
        let noAlpha = "alpha" ∈ B
        let subtracted = B ∖ A
        let complement = A′
        
        println("Asserting some basic properties of sets")
        println("A == A -> \(A == A)")
        println("A ∩ B == B ∩ A -> \(A ∩ B == B ∩ A)")
        println("A ∪ B == B ∪ A -> \(A ∪ B == B ∪ A)")
        println("A ∪ A == A -> \(A ∪ A == A)")
        println("A ∪ Ø == A -> \(A ∪ Ø == A)")
        println("A ∖ A == Ø -> \(A ∖ A == Ø)")
        println("A ∪ A′ == U -> \(A ∪ A′ == U)")
        println()
        println("De Morgan's Laws")
        println("First law:  (A ∪ B)′ == A′ ∩ B′ -> \((A ∪ B)′ == A′ ∩ B′)")
        println("Second law: (A ∩ B)′ == A′ ∪ B′ -> \((A ∩ B)′ == A′ ∪ B′)")
    }
}
