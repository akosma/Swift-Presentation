class Customer<T: Behavior> {
    var behavior = T()
    
    func doSomething() {
        println("My behavior: \(behavior.description)")
    }
}

protocol Behavior : Printable {
    init ()
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

var good = Customer<GoodBehavior>()
good.doSomething()

var bad = Customer<BadBehavior>()
bad.doSomething()
