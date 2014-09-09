import Cocoa

public class ObjCDemo: BaseDemo {

    public override func show() {

        typealias BOOL = Bool
        
        let YES = true
        let NO = false
        
        var value : BOOL = YES

        println("YES = \(YES)")
        println("NO = \(NO)")

    }
}
