func allocInitCreator<T: Widget>() -> T {
    println("alloc init creator")
    return T()
}

func opNewCreator<T: Widget>() -> T {
    println("op new creator")
    return T()
}

func mallocCreator<T: Widget>() -> T {
    println("malloc creator")
    return T()
}

public protocol Widget {
    init()
}

public class Label : Widget {
    required public init () {
        println("constructing a label")
    }
    
    public func say() {
        
    }
}

public class Field : Widget {
    required public init () {
        println("constructing a field")
    }
}

public class WidgetManager<T> {
    private let creator : (() -> T)
    
    init (creator: (() -> T)) {
        self.creator = creator
    }
    
    public func createWidget() -> T {
        return creator()
    }
}

var man = WidgetManager<Field>(opNewCreator)
var label = man.createWidget()

