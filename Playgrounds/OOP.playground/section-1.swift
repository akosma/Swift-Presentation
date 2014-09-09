let π = 3.14159

func circleArea(radius r: Double) -> Double {
    return π * r * r
}

let area = circleArea(radius: 1)
println("Circle area is \(area)")

class Circle {
    var r: Double
    init(radius: Double) {
        r = radius
    }
    init(diameter d: Double) {
        r = d/2
    }
    func circumference() -> Double {
        return 2*π*r
    }
}

let circle = Circle(radius: 2)
println("Circle circumference is \(circle.circumference())")

let circumferences = [1, 2].map { r in Circle(radius: r).circumference() }
println("Circumferences: \(circumferences)")
