import Foundation

func 💪😠💪(s: String) -> String {
    
    // Inversed text taken from 
    // http://www.upsidedowntext.com/
    let f = ["a": "ɐ", "b": "q", "c": "ɔ", "d": "p", "e": "ǝ",
        "f": "ɟ", "g": "ƃ", "h": "ɥ", "i": "ᴉ", "j": "ɾ",
        "k": "ʞ", "l": "l", "m": "ɯ", "n": "u", "o": "o",
        "p": "d", "q": "b", "r": "ɹ", "s": "s", "t": "ʇ",
        "u": "n", "v": "ʌ", "w": "ʍ", "x": "x", "y": "ʎ", "z": "z"]
    var r = ""
    for c in s {
        if let m = f["\(c)"] {
            r = m + r
        }
        else {
            r = " " + r
        }
    }
    return r
}

func 😨(e: Bool, m : String) {
    if (!e) {
        let f = "💪😠💪︵ " + 💪😠💪(m)
        println(f)
    }
}


final public class AngryDemo: BaseDemo {
    
    override public var description : String {
        return "This demo shows how to abuse the support for Emoji in Swift."
    }
    
    override public var URL : NSURL {
        return NSURL(string: "http://terribleswiftideas.tumblr.com/post/88396093525/table-via-gregtitus")
    }

    override public func show() {
        var b = false
        😨(b, "what have you done")
    }
}
