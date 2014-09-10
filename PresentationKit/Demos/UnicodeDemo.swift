import Cocoa

public class UnicodeDemo: BaseDemo {

    override public var description : String {
        return "This demo shows how abuse Emojis to the max."
    }
    
    public override var tweet : NSURL {
        return NSURL(string: "https://twitter.com/futurepaul/status/473902211463118848")
    }
    
    public override func show() {
        let 🌍 = "🐶🐺🐱🐭🐹🐰🐸🐯🐨🐻🐷🐽🐮🐗🐵🐒🐴🐑🐘🐼🐧🐦🐤🐥🐣🐔🐍🐢🐛🐝🐜🐞🐌🐙🐚🐠🐟🐬🐳🐋🐄🐏🐀🐃🐅🐇🐉🐎🐐🐓🐕🐖🐁🐂🐲🐡🐊🐫🐪🐆🐈🐩"
        
        var 🚢 : [String] = []
        
        for 💕 in 🌍 {
            🚢.append("\(💕)\(💕)")
        }
        
        println(🚢)
    }
}
