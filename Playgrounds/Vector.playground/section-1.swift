import Foundation

let π = M_PI

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

prefix operator √ {}
prefix func √ (value: Double) -> Double {
    return sqrt(value)
}

postfix operator ∘ {}
postfix func ∘ (degrees: Double) -> Double {
    return degrees * π / 180
}

func * (scalar: Double, vector: Vector2D) -> Vector2D {
    return Vector2D(x: vector.x * scalar,
                    y: vector.y * scalar)
}

func + (v1: Vector2D, v2: Vector2D) -> Vector2D {
    return Vector2D(x: v1.x + v2.x,
                    y: v1.y + v2.y)
}

func - (v1: Vector2D, v2: Vector2D) -> Vector2D {
    return Vector2D(x: v1.x - v2.x,
                    y: v1.y - v2.y)
}


infix operator ⦁ {}
func ⦁ (v1: Vector2D, v2: Vector2D) -> Double {
    return v1.x * v2.x + v1.y * v2.y
}

prefix operator | {}
prefix func | (vector: Vector2D) -> Double {
    return √(vector.x * vector.x
             + vector.y * vector.y)
}

postfix operator | {}
postfix func | (vector: Vector2D) -> Vector2D {
    return vector
}

infix operator ⦠ {}
func ⦠ (v1: Vector2D, v2: Vector2D) -> Double {
    return acos((v1 ⦁ v2) / (|v1| * |v2|))
}

let vector1 = Vector2D(x: 3, y: 7)
let length = |vector1|

let multiplied = 2 * vector1

let vector2 = Vector2D(x: -4, y: 2)
let substracted = vector1 - vector2

let unitVector = Vector2D(x: 0.6, y: 0.8)
let unitVectorLength = |unitVector|

let product = vector1 ⦁ vector2
let angleDifference = vector2 ⦠ vector1

let angle = 90∘
