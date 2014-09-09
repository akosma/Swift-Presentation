import Cocoa

func 🌈(hex: Int) -> NSColor {
    let r = CGFloat((hex & 0xff0000) >> 16) / 255.0
    let g = CGFloat((hex & 0x00ff00) >> 8) / 255.0
    let b = CGFloat(hex & 0x0000ff) / 255.0
    return NSColor(red: r, green: g, blue: b, alpha: 1.0)
}

let bondi = 🌈(0x41ACB7)
let strawberry = 🌈(0xA73346)
let blueberry = 🌈(0x3484AB)
let lime = 🌈(0x34A53A)
let grape = 🌈(0x6A36A7)
let tangerine = 🌈(0xBA6B3F)
