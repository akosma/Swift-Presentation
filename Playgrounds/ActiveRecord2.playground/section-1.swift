public protocol Property : Printable {
    var key: String {
        get
    }
    
    var sqlValue: String {
        get
    }
}

public struct TypedProperty<T> : Property {
    public var key: String
    public var value: T
    
    public var description : String {
        get {
            return "\(key) = \(value)"
        }
    }
    
    public var sqlValue : String {
        // Clearly this is vulnerable to
        // SQL injection... be careful!
        if value is String {
            return "\"\(value)\""
        }
        return "\(value)"
    }
}

public protocol Storable {
    var tableName : String { get }
    var id : Int? { get }
    var destroyed : Bool { get }
    var inserted : Bool { get }
    var dirty : Bool { get }
    
    func setProperty<T: Hashable>(#key: String, value: T)
    func getProperties() -> PropertyBag
    
    class func getAll() -> [Int: Storable]
}

public typealias Table = [Int: Storable]
public typealias PropertyBag = [String : Property]

public protocol Storage {
    init()
    func create(item : Storable) -> Int?
    func read(predicate: PropertyBag?) -> Table
    func update(item: Storable)
    func destroy(item: Storable)
}

public enum FieldType {
    case Text
    case Number
    case Date
}

// Swift still does not allow for class variables...
var table : Table?

final public class SQLiteStorage : Storage {
    
    public init () { }
    
    public func create(item : Storable) -> Int? {
        execute(insertStatement(item))
        let id = table!.count
        table![id] = item
        return id
    }

    public func read(predicate: [String: Property]?) -> Table {
        // For the moment we skip the use
        // of the predicate, and just 
        // return all we've got
        return table!
    }

    public func update(item : Storable) {
        execute(updateStatement(item))
    }
    
    public func destroy(item: Storable) {
        execute(deleteStatement(item))
        table!.removeValueForKey(item.id!)
    }
    
    private func createTable() {
        if table == nil {
            println("(creating table)")
            println()
            table = Table()
        }
    }
    
    private func execute(statement: String) {
        createTable()
        println(statement)
        println()
    }
    
    private func insertStatement(item : Storable) -> String {
        var keysArray : [String] = []
        var valuesArray : [String] = []
        for (key, prop) in item.getProperties() {
            keysArray.append(prop.key)
            valuesArray.append(prop.sqlValue)
        }
        let keys = ", ".join(keysArray)
        let values = ", ".join(valuesArray)
        var result = "INSERT INTO \(item.tableName) (\(keys)) VALUES (\(values))"
        return result
    }
    
    private func updateStatement(item : Storable) -> String {
        var pairsArray : [String] = []
        for (key, prop) in item.getProperties() {
            pairsArray.append("\(prop.key) = \(prop.sqlValue)")
        }
        let pairs = ", ".join(pairsArray)
        let result = "UPDATE \(item.tableName) SET \(pairs) WHERE id = \(item.id!)"
        return result
    }
    
    private func deleteStatement(item : Storable) -> String {
        return "DELETE FROM \(item.tableName) WHERE id = \(item.id!)"
    }
}

public class Record<S: Storage> : Storable {
    lazy private var storage : S = S()
    
    private var properties = [String: Property]()
    private var _id : Int?
    private var _inserted : Bool = false
    private var _dirty : Bool = false
    private var _destroyed : Bool = false
    
    public var tableName : String {
        return ""
    }
    private var fields : [String : FieldType] {
        return [String : FieldType]()
    }
    
    public var id : Int? {
        return _id
    }
    public var inserted : Bool {
        return _inserted
    }
    public var dirty : Bool {
        return _dirty
    }
    public var destroyed : Bool {
        return _destroyed
    }
    
    init() { }
    
    public var description : String {
        get {
            var result : [String] = ["Record id \(id!)"]
            for (key, prop) in properties {
                result.append(prop.description)
            }
            result.append("Inserted: \(inserted)")
            result.append("Dirty: \(dirty)")
            result.append("Destroyed: \(destroyed)")
            return "\n".join(result)
        }
    }
    
    public func save() {
        if destroyed {
            println("(object destroyed, nothing to save)")
            println()
        }
        else {
            if inserted {
                if dirty {
                    storage.update(self)
                    _dirty = false
                }
                else {
                    println("(object not dirty, nothing to save)")
                    println()
                }
            }
            else {
                _id = storage.create(self)
                _inserted = true
                _dirty = false
            }
        }
    }
    
    public func destroy() {
        if !destroyed {
            storage.destroy(self)
            _dirty = false
            _destroyed = true
        }
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
                _dirty = true
            }
        }
    }
    
    public func getProperties() -> PropertyBag {
        return properties
    }
    
    public class func getAll() -> Table {
        return S().read(nil)
    }
}

public class User<T : Storage> : Record<T> {
    public override var tableName : String {
        return "users"
    }
    
    public override var fields : [String : FieldType] {
        return ["first_name": .Text,
            "age": .Number,
            "last_name": .Text]
    }
}

typealias StoredUser = User<SQLiteStorage>

let peter = StoredUser()
peter.setProperty(key: "first_name", value: "Peter")
peter.setProperty(key: "last_name", value: "Smith")
peter.setProperty(key: "age", value: 39)
peter.setProperty(key: "age", value: 40) // Ups!
peter.setProperty(key: "married", value: true) // This does nothing

peter.save() // insertion done here
peter.save() // no update done here
peter.save() // no update done here

peter.setProperty(key: "first_name", value: "Peter Samuel")
peter.save() // update done here!

peter.setProperty(key: "first_name", value: "Peter Samuel")
peter.save() // no update done here

let paul = StoredUser()
paul.setProperty(key: "first_name", value: "Paul")
paul.setProperty(key: "last_name", value: "Preston")
paul.setProperty(key: "age", value: 55)

paul.save() // insertion here

var users = StoredUser.getAll()

peter.destroy()

println(peter.description)
println()
println(paul.description)
println()

paul.destroy()
