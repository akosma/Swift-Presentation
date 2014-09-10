import Foundation

typealias Filter = String -> String

func caesarsCypher(shift: Int) -> Filter {
    return { input in
        println("caesarsCypher")
        var result = NSMutableString()
        var nsInput = input as NSString
        for c in 0..<nsInput.length {
            let value = nsInput.characterAtIndex(c) + shift
            let newChar = NSString(format: "%C", value)
            result.appendString(newChar)
        }
        return result as String
        
    }
}

func caesarsDecypher(shift: Int) -> Filter {
    return { input in
        println("caesarsDecypher")
        var result = NSMutableString()
        var nsInput = input as NSString
        for c in 0..<nsInput.length {
            let value = nsInput.characterAtIndex(c) - shift
            let newChar = NSString(format: "%C", value)
            result.appendString(newChar)
        }
        return result as String
    }
}

func uppercase() -> Filter {
    return { input in
        println("uppercase")
        return (input as NSString).uppercaseString as String
    }
}

func lowercase() -> Filter {
    return { input in
        println("lowercase")
        return (input as NSString).lowercaseString as String
    }
}

func invert() -> Filter {
    return { input in
        println("invert")
        let f = ["a": "ɐ", "b": "q", "c": "ɔ", "d": "p", "e": "ǝ",
            "f": "ɟ", "g": "ƃ", "h": "ɥ", "i": "ᴉ", "j": "ɾ",
            "k": "ʞ", "l": "l", "m": "ɯ", "n": "u", "o": "o",
            "p": "d", "q": "b", "r": "ɹ", "s": "s", "t": "ʇ",
            "u": "n", "v": "ʌ", "w": "ʍ", "x": "x", "y": "ʎ", "z": "z",
            "A": "∀", "B": "q", "C": "Ɔ", "D": "p", "E": "Ǝ", "F": "Ⅎ",
            "G": "ƃ", "H": "H", "I": "I", "J": "ſ", "K": "ʞ", "L": "˥",
            "M": "W", "N": "N", "O": "O", "P": "Ԁ", "Q": "Q", "R": "ɹ",
            "S": "S", "T": "┴", "U": "∩", "V": "Λ", "W": "M", "X": "X",
            "Y": "⅄", "Z": "Z",
            "ɐ": "a", "ɔ": "c", "ǝ": "e",
            "ɟ": "f", "ƃ": "g", "ɥ": "h", "ᴉ": "i", "ɾ": "j",
            "ʞ": "k", "ɯ": "m",
            "ɹ": "r", "ʇ": "t",
            "ʌ": "v", "ʍ": "w", "ʎ": "y",
            "∀": "A", "Ǝ": "E", "Ⅎ": "F",
            "ſ": "J", "˥": "L",
            "Ԁ": "P",
            "┴": "T", "∩": "U", "Λ": "V",
            "⅄": "Y"]
        var result = ""
        for c in input {
            if let m = f["\(c)"] {
                result = m + result
            }
            else {
                result = String(c) + result
            }
        }
        return result
    }
}

func composeFilters(filter1: Filter, filter2: Filter) -> Filter {
    return { input in
        filter1(filter2(input))
    }
}

infix operator ---<> { associativity left }
func ---<> (filter1: Filter, filter2: Filter) -> Filter {
    return composeFilters(filter1, filter2)
}

/*
let input1 = "Lorem ipsum dolor sit amet und so weiter"
let input2 = "Il etait une fois..."

let filter = invert() ---<> uppercase()
let result1 = filter(input1)
let result2 = filter(input2)

let roundtrip = caesarsCypher(14) ---<> caesarsDecypher(14)
let result4 = roundtrip("Adrian Kosmaczewski")
*/

let obfuscate = uppercase() ---<> invert() ---<> caesarsCypher(14)
let deObfuscate = caesarsDecypher(14) ---<> invert() ---<> lowercase()

let roundtrip2 = deObfuscate ---<> obfuscate
let test = roundtrip2("May the force be with you")

println(test)
