import Cocoa

protocol Behavior : Printable {
    init ()
}

class Customer<T: Behavior> {
    var behavior = T()
    
    func doSomething() {
        println("My behavior: \(behavior.description)")
    }
}

final class GoodBehavior : Behavior {
    var description : String {
        return "well behaved"
    }
}

final class BadBehavior : Behavior {
    var description : String {
        return "bad behaved"
    }
}



public class GenericsDemo: BaseDemo {

    override public var description : String {
        return "This demo shows how to use generics to compose classes, similar to policy classes described by Alexandrescu."
    }
    
    public override func show() {
        var good = Customer<GoodBehavior>()
        good.doSomething()
        
        var bad = Customer<BadBehavior>()
        bad.doSomething()
    }
}
