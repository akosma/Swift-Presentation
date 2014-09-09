import Foundation

public protocol Property : Printable {
    var key: String {
        get
    }
    
    var sqlValue: String {
        get
    }
}

struct TypedProperty<T> : Property {
    var key: String
    var value: T
    
    var description : String {
        get {
            return "\(key) = \(value)"
        }
    }
    
    var sqlValue : String {
        if value is String {
            return "\"\(value)\""
            }
            return "\(value)"
    }
}

public class ActiveRecord<U : Storable>  {
    private var tableName : String
    private var properties = [String: Property]()
    private var fields : [String: String]
    private var id : Int?
    private var inserted : Bool = false
    private var dirty : Bool = false
    private var destroyed : Bool = false
    
    public var description : String {
        get {
            var result : [String] = ["Record id \(id!) in table \"\(tableName)\""]
            for (key, prop) in properties {
                result.append(prop.description)
            }
            result.append("Inserted: \(inserted)")
            result.append("Dirty: \(dirty)")
            result.append("Destroyed: \(destroyed)")
            return "\n".join(result)
        }
    }
    
    init () {
        self.tableName = U.tableName()
        self.fields = U.fields()
    }
    
    public func setProperty<T: Hashable>(#key: String, value: T) {
        if !destroyed && fields.indexForKey(key) != nil {
            var shouldStore = false
            if properties.indexForKey(key) == nil {
                // The key does not exist, this is a new property
                shouldStore = true
            }
            else {
                // The key exists, is it a new value?
                var oldValue = properties[key] as TypedProperty<T>
                if (oldValue.value != value) {
                    shouldStore = true
                }
            }
            
            if shouldStore {
                properties[key] = TypedProperty<T>(key: key, value: value)
                dirty = true
            }
        }
    }
    
    public func findAll() -> [U] {
        return [U]()
    }
    
    public func save() {
        if destroyed {
            execute("(nothing to save)")
        }
        else {
            if inserted {
                if dirty {
                    execute(updateStatement())
                    dirty = false
                }
                else {
                    execute("(nothing to save)")
                }
            }
            else {
                execute(insertStatement())
                inserted = true
                dirty = false
            }
        }
    }
    
    public func destroy() {
        if inserted {
            dirty = false
            destroyed = true
            execute(deleteStatement())
        }
    }
    
    private func execute(statement: String) {
        println(statement)
        println()
    }
    
    private func insertStatement() -> String {
        var keysArray : [String] = []
        var valuesArray : [String] = []
        for (key, prop) in properties {
            keysArray.append(prop.key)
            valuesArray.append(prop.sqlValue)
        }
        let keys = ", ".join(keysArray)
        let values = ", ".join(valuesArray)
        var result = "INSERT INTO \(tableName) (\(keys)) VALUES (\(values))"
        id = 1 // This should come from the database...
        return result
    }
    
    private func updateStatement() -> String {
        if id != nil {
            var pairsArray : [String] = []
            for (key, prop) in properties {
                pairsArray.append("\(prop.key) = \(prop.sqlValue)")
            }
            let pairs = ", ".join(pairsArray)
            let result = "UPDATE \(tableName) SET \(pairs) WHERE id = \(id!)"
            return result
        }
        return ""
    }
    
    private func deleteStatement() -> String {
        if id != nil {
            return "DELETE FROM \(tableName) WHERE id = \(id!)"
        }
        return ""
    }
}

public protocol Storable {
    class func fields() -> [String: String]
    class func tableName() -> String
}

public class User : Storable {
    public class func tableName() -> String {
        return "users"
    }
    
    public class func fields() -> [String: String] {
        return ["first_name": "string",
            "age": "int",
            "last_name": "string"]
    }
}

final public class ActiveRecordDemo: BaseDemo {
    
    override public var description : String {
        return "This demo shows how to use Generics to create a very simple implementation of the Active Record design pattern."
    }
    
    override public var URL : NSURL {
        return NSURL(string: "https://github.com/akosma/remproject/blob/master/src/storage/ActiveRecord.h")
    }

    override public func show() {
        let john = ActiveRecord<User>()
        john.setProperty(key: "first_name", value: "John")
        john.setProperty(key: "last_name", value: "Smith")
        john.setProperty(key: "age", value: 64)
        john.setProperty(key: "age", value: 46) // Ups!
        john.setProperty(key: "married", value: true) // This does nothing
        
        john.save() // insertion done here
        john.save() // no update done here
        john.save() // no update done here
        
        john.setProperty(key: "first_name", value: "John Zachary")
        john.save() // update done here!
        
        john.setProperty(key: "first_name", value: "John Zachary")
        john.save() // no update done here
        
        john.destroy()
        john.save() // nothing to save here
        
        println(john.description)
    }
}
