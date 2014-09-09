// Set operations taken from
// https://en.wikipedia.org/wiki/Set_(mathematics)

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

// Does not belong
infix operator ∉ {}
func ∉ (obj: AnyObject, set: NSSet) -> Bool {
    return !(obj ∈ set)
}

// Subset
infix operator ⊆ {}
func ⊆ (s1: NSSet, s2: NSSet) -> Bool {
    return s1.isSubsetOfSet(s2)
}

// Cardinality
prefix operator | {}
prefix func | (set: NSSet) -> Int {
    return set.count
}

postfix operator | {}
postfix func | (set: NSSet) -> NSSet {
    return set
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

// Symmetric difference
infix operator ∆ {}
func ∆ (s1: NSSet, s2: NSSet) -> NSSet {
    return (s1 ∖ s2) ∪ (s2 ∖ s1)
}

// Equality
func == (s1: NSSet, s2: NSSet) -> Bool {
    return s1.isEqualToSet(s2)
}

// Inequality
func != (s1: NSSet, s2: NSSet) -> Bool {
    return !s1.isEqualToSet(s2)
}

// Cartesian product
infix operator × { associativity left precedence 150 }
func × (s1: NSSet, s2: NSSet) -> NSSet {
    var result = NSMutableSet()
    for obj1 in s1 {
        for obj2 in s2 {
            result.addObject([obj1, obj2])
        }
    }
    return result
}

let A = ⟨[1, "alpha", "beta", "gamma", 23, 23]⟩
let B = ⟨["omega", "gamma", "delta", 23, 63, 1, 1, 1]⟩
let C = ⟨[1, "alpha"]⟩
let D = ⟨["Brazil", "Switzerland", "Austria"]⟩

let intersection = A ∩ B
let union = A ∪ B
let noAlpha = "alpha" ∈ B
let yesAlpha = "alpha" ∉ B
let isNotSubset = A ⊆ B
let isSubset = C ⊆ A
let cardinality = |A|
let subtracted = B ∖ A
let complement = A′
let symmetric = A ∆ B
let product = A × B

// Asserting some basic properties of sets
assert(A == A                 , "A set is equal to itself")
assert(A ∩ B == B ∩ A         , "Intersection is commutative")
assert(A ∪ B == B ∪ A         , "Union is commutative")
assert(A ∪ A == A             , "Union with itself is neutral")
assert(A ∪ Ø == A             , "The empty set is neutral in union")
assert((C ⊆ A) && (C ∪ A) == A, "Condition to be a subset")
assert((A ⊆ (A ∪ B))          , "Condition of inclusion")
assert(A ∖ A == Ø             , "Removing a set from itself yields the empty set")
assert(A ⊆ U                  , "Any set is part of the Universal set")
assert(A ∪ A′ == U            , "The union of a set with its complementary yields the universal set")
assert(|(A × B)| == |A| * |B| , "The number of items in a product set is equal to the product of the number of items")
assert(A × Ø == Ø             , "The empty set is the absorbing element of the product")
assert(A × (B ∪ C) == A × B ∪ A × C, "Product is distributive")

// De Morgan's Laws
assert((A ∪ B)′ == A′ ∩ B′    , "First law: the complement of A union B equals the complement of A intersected with the complement of B.")
assert((A ∩ B)′ == A′ ∪ B′    , "Second law: the complement of A intersected with B is equal to the complement of A union to the complement of B.")
