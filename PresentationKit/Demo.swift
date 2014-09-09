import Foundation

public protocol Demo : Printable {
    var tweet : NSURL { get }
    var URL : NSURL { get }
    var sourceCode : NSAttributedString { get }

    func explain()
    func explain(voice: String)
    func show()
    func copyCode()
}
