import Cocoa

var YES : Bool {
    get {
        return arc4random_uniform(2) == 1
    }
}

var NO : Bool {
    get {
        let url = NSURL(string: "http://schwa.io/no.json")
        let data = NSData(contentsOfURL: url)
        var error : NSError?
        let json : NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions(),
            error: &error) as NSDictionary
        let no = json["_no"] as Bool
        return no
    }
}

YES
YES
YES == YES

NO
NO
