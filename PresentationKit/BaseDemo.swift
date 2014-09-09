import AppKit

public class BaseDemo : NSObject, Demo {
    private var source : NSAttributedString?

    public override required init() { }
    
    public var tweet : NSURL {
        return NSURL(string: "http://akos.ma/swift")
    }
    
    public var URL : NSURL {
        return NSURL(string: "http://akos.ma/swift")
    }
    
    override public var description : String {
        return ""
    }
    
    final public var sourceCode : NSAttributedString {
        if source == nil {
            let url = findURL()
            var options : NSDictionary = [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
            ]
            
            // Load the NSMutableAttributedString corresponding to the 
            // contents of the HTML file
            var error : NSError? = nil;
            let string = NSMutableAttributedString(URL:url,
                options:options,
                documentAttributes:nil,
                error:&error)
            
            let range = NSMakeRange(0, string.length - 1)
            let newFont = NSFont(name: "Menlo", size: 18.0)
            string.addAttribute(NSFontAttributeName, value: newFont, range: range)
            source = string
        }
        return source!
    }
    
    final public func explain() {
        explain("Alex")
    }
    
    private func findURL() -> NSURL {
        // Let's find out the path of the HTML file to show
        var filename = "html/\(self.className).swift"
        
        // Swift frameworks are namespaced by default; in this case,
        // the product name is used, and the classes have that prefix.
        // We strip the prefix to match the name of the HTML file.
        filename = filename.stringByReplacingOccurrencesOfString("PresentationKit.",
            withString: "")
        
        // Get the path in the bundle of the framework
        let bundle = NSBundle(forClass: Presentation.self)
        let path : NSString = bundle.pathForResource(filename, ofType:"html")!
        let url = NSURL.fileURLWithPath(path)!

        return url
    }
    
    final public func copyCode() {
        // Copy the contents of the file to the pasteboard
        let url = findURL()
        var rawString = NSString(contentsOfURL: url,
            encoding: NSUTF8StringEncoding,
            error: nil)
        var pasteboard = NSPasteboard.generalPasteboard()
        pasteboard.declareTypes([NSHTMLPboardType], owner:nil)
        pasteboard.setString(rawString, forType:NSHTMLPboardType)
    }
    
    final public func explain(voice: String) {
        println("\(voice) says: \(self.description)")
        println()
        
        // Unfortunately NSSpeechSynthesizer does not currently 
        // work in the playground...
        // So we use an NSTask to pipe the text to the OS instead!
        // var speech = NSSpeechSynthesizer()
        // speech.startSpeakingString("Boom")
        let task = NSTask()
        task.launchPath = "/usr/bin/say"
        task.arguments = [ "--voice=\(voice)", self.description ]
        task.launch()
    }
    
    public func show() {
        // To be overridden by subclasses
    }
}
