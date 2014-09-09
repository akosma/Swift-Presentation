import Cocoa

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

public class JavaScriptDemo: BaseDemo {

    override public var description : String {
        return "This demo shows how to make JavaScript developers feel right at home."
    }
    
    public override var tweet : NSURL {
        return NSURL(string: "https://twitter.com/jonathanpenn/status/475038610077401088")
    }
    
    public override var URL : NSURL {
        return NSURL(string: "https://gist.github.com/jonathanpenn/c69e7b8485e29ffff598")
    }
    
    public override func show() {
        println("(NaN == NaN) = \(NaN == NaN)")
        println("(NaN != NaN) = \(NaN != NaN)")
        println("([] + []) = \([] + [])")
        println("// WAT")
    }
}
