import Foundation

// Slow versions
func slowFibonacci(n: Int64) -> Int64 {
    return n < 2 ? n : slowFibonacci(n - 1) + slowFibonacci(n - 2)
}

let phi1 = slowFibonacci(4) / slowFibonacci(3)


func slowFactorial(n: Int64) -> Int64 {
    return n == 0 ? 1 : n * slowFactorial(n - 1)
}

let fac1 = slowFactorial(20)


// Faster version of the Fibonacci
var dict = Dictionary<Int64, Int64>()

func fastFibonacci(n: Int64) -> Int64 {
    if let result = dict[n] {
        return result
    }
    let result = n < 2 ? n : fastFibonacci(n - 1) + fastFibonacci(n - 2)
    dict[n] = result
    return result
}

let phi2 = fastFibonacci(90) / fastFibonacci(89)

println("phi2: \(phi2)")



// Fast and generic version
func memoize<T : Hashable, U>(body: (T -> U)) -> (T -> U) {
    var memo = Dictionary<T, U>()
    var result : (T -> U)
    result = { x in
        if let q = memo[x] {
            return q
        }
        let r : U = body(x)
        memo[x] = r
        return r
    }
    return result
}


// Memoized Factorial
var factorial : (Int64 -> Int64)
factorial = memoize { n in
    n == 0 ? 1 : n * factorial(n - 1)
}

let fact = factorial(10)


// Memoized Fibonacci
var memoFibo : (Int64 -> Int64)
memoFibo = memoize { n in
    n < 2 ? n : memoFibo(n - 1) + memoFibo(n - 2)
}

let phi3 = Double(memoFibo(90)) / Double(memoFibo(89))
