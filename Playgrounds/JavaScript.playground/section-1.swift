// Source
// https://twitter.com/jonathanpenn/status/475038610077401088
// https://gist.github.com/jonathanpenn/c69e7b8485e29ffff598

class NaNClass {}
let NaN = NaNClass()

func == (n1: NaNClass, n2: NaNClass) -> Bool {
    return false
}

func != (n1: NaNClass, n2: NaNClass) -> Bool {
    return true
}

func + (a1: Array<Any>, a2: Array<Any>) -> String {
    return ""
}

NaN == NaN // false
NaN != NaN // false
[] + []    // ""
