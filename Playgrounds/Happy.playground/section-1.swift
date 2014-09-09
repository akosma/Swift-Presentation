// Upside-down text from 
// http://www.upsidedowntext.com/

func 💪😠💪(s: String) -> String {
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

var b = false
😨(b, "this will not work. promise.")
