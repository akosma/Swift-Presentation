import Foundation

public struct PresentationGenerator : GeneratorType {
    var index : Int = 0
    var demoDictionary : [String : BaseDemo.Type]
    
    public init(dict: [String : BaseDemo.Type]) {
        self.demoDictionary = dict
    }
    
    public typealias Element = BaseDemo
    mutating public func next() -> Element? {
        var demoSequence = demoDictionary.values.array
        if index < demoSequence.count {
            var type = demoSequence[index]
            self.index += 1
            return type()
        }
        return nil
    }
}

public class Presentation : NSObject, SequenceType {
    
    public typealias GeneratorType = PresentationGenerator
    
    private let name : String

    private let demoDictionary : [String : BaseDemo.Type] = [
        "ar":    ActiveRecordDemo.self,
        "angry": AngryDemo.self,
        "99b":   NinetyNineBeersDemo.self,
        "filt":  FiltersDemo.self,
        "noah":  UnicodeDemo.self,
        "curry": CurriedDemo.self,
        "sets":  SetsDemo.self,
        "js":    JavaScriptDemo.self,
        "math":  MathDemo.self,
        "gene":  GenericsDemo.self,
        "objc":  ObjCDemo.self
    ]
    
    public init (name: String) {
        self.name = name
        super.init()
        
        let today = date()
        println("Welcome to the \(name) presentation!")
        println("Today is \(today).")
        println()
    }
    
    public subscript(number: Int) -> Demo? {
        return getDemo(number)
    }
    
    public subscript(name: String) -> Demo? {
        return getDemo(name)
    }
    
    public func getDemo(number: Int) -> Demo? {
        var demoSequence = demoDictionary.values.array
        if number < demoSequence.count {
            return demoSequence[number]()
        }
        return nil
    }

    public func getDemo(name: String) -> Demo? {
        var type : BaseDemo.Type? = demoDictionary[name]
        if type != nil {
            return type!()
        }
        return nil
    }
    
    private func date() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .LongStyle
        let us = NSLocale(localeIdentifier:"en_US");
        dateFormatter.locale = us
        let date = NSDate()
        return dateFormatter.stringFromDate(date)
    }
    
    public func generate() -> GeneratorType {
        var gen = PresentationGenerator(dict: demoDictionary)
        return gen
    }
}
