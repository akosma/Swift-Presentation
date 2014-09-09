import Foundation

typealias Filter = String -> String

func caesarsCypher(shift: Int) -> Filter {
    return { input in
        var result = ""
        typealias US = UnicodeScalar
        let char = US.convertFromExtendedGraphemeClusterLiteral
        for c in input {
            let value = char(String(c)).value + shift
            let newChar = Character(UnicodeScalar(value))
            result += String(newChar)
        }
        return result
    }
}

func uppercase() -> Filter {
    return { input in
        return (input as NSString).uppercaseString as String
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



public class FiltersDemo: BaseDemo {

    override public var description : String {
        return "This demo shows how to use functions and custom operators to represent and chain operations."
    }
    
    override public var URL : NSURL {
        return NSURL(string: "http://www.objc.io/books/")
    }
    
    public override func show() {
        let filter = caesarsCypher(4) ---<> uppercase()
        let input = "Lorem ipsum dolor sit amet und so weiter"
        let result = filter(input)
        
        println("\(input) -> \(result)")
    }
}
