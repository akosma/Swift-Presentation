final public class NinetyNineBeersDemo: BaseDemo {

    override public var description : String {
        return "This demo is a very personal take on the \"99 bottles of beer\" song and puzzle."
    }
    
    override public var URL : NSURL {
        return NSURL(string: "http://rosettacode.org/wiki/99_Bottles_of_Beer")
    }

    override public func show() {
        var beers = "🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺"
        var count = countElements(beers)
        
        func sayGlasses(count: Int) -> String {
            return count > 1 ? "\(count) glasses" : (count == 1 ? "1 glass" : "No more glasses")
        }
        
        while count >= 0 {
            var glasses = sayGlasses(count)
            println("\(glasses) of beer on the wall,")
            println("\(glasses) of beer.")
            if count > 0 {
                beers = dropLast(beers)
                count = countElements(beers)
                var glasses = sayGlasses(count)
                println("Take one down and pass it around,")
                println("\(glasses) of beer on the wall.")
                println(beers)
            }
            else {
                break
            }
        }
    }
}
