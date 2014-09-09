import Cocoa

typealias ScalarFunction = Double -> Double
typealias Trapezoidal = (Double, Double) -> Double

prefix operator ∑ {}
prefix func ∑ (array: [Double]) -> Double {
    var result = 0.0
    for value in array {
        result += value
    }
    return result
}

func ~= (left: Double, right: Double) -> Bool {
    let ε : Double = 0.001
    var δ = left - right
    return abs(δ) <= ε
}

// Trapezoidal rule adapted from
// http://www.numericmethod.com/About-numerical-methods/numerical-integration/trapezoidal-rule
prefix operator ∫ {}
prefix func ∫ (𝑓: ScalarFunction) -> Trapezoidal {
    return { (min : Double, max : Double) -> (Double) in
        let steps = 100
        let h = abs(min - max) / Double(steps)
        var surfaces : [Double] = []
        
        for position in 0..<steps {
            let x1 = min + Double(position) * h
            let x2 = x1  + h
            let y1 = 𝑓(x1)
            let y2 = 𝑓(x2)
            let s = (y1 + y2) * h / 2
            surfaces.append(s)
        }
        return ∑surfaces
    }
}

public class MathDemo: BaseDemo {
    
    override public var description : String {
        return "This demo shows how to use custom operations to represent complex mathematical operations."
    }
    
    public override var URL : NSURL {
        return NSURL(string: "https://github.com/mattt/Euler")
    }
    
    public override func show() {
        
        let π = M_PI
        let sum = ∑[1, 2, 3, 5, 8, 13]
        
        // Function taken from the "fast numeric integral" example from
        // http://www.codeproject.com/Articles/31550/Fast-Numerical-Integration
        func 𝑓 (x: Double) -> Double {
            return exp(-x / 5.0) * (2.0 + sin(2.0 * x))
        }
        
        let integral = (∫𝑓) (0, 100)
        let sinIntegral = ∫sin
        let curve1 = sinIntegral(0, π/2)
        let curve2 = sinIntegral(0, π)
        assert(curve1 ~= 1, "Almost 1")
        assert(curve2 ~= 2, "Almost 2")
        
        println("sum: \(sum) – integral: \(integral) – curve1: \(curve1) – curve2: \(curve2)")
    }
}
