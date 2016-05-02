import Foundation
import Unbox
import Wrap

enum Profession: String, UnboxableEnum {
    case Developer
    case Lawyer
    
    static func unboxFallbackValue() -> Profession {
        return .Lawyer
    }
}

struct Device: Unboxable {
    let name: String
    let inchSize: Double
    
    init(unboxer: Unboxer) {
        self.name = unboxer.unbox("name")
        self.inchSize = unboxer.unbox("inchSize")
    }
}

struct User: Unboxable {
    let name: String
    let age: Int
    let profession: Profession
    let devices: [Device]
    
    init(unboxer: Unboxer) {
        self.name = unboxer.unbox("name")
        self.age = unboxer.unbox("age")
        self.profession = unboxer.unbox("profession")
        self.devices = unboxer.unbox("devices")
    }
}

// Load JSON data
let bundle = NSBundle.mainBundle()
let path = bundle.pathForResource("C", ofType: ".json")!
let data = NSData(contentsOfFile: path)!

// Perform unboxing
do {
    let user: User = try Unbox(data)
    print(user)
    
    let wrapData: NSData = try Wrap(user)
    let user2: User = try Unbox(wrapData)
    print(user2)
} catch {
    print(error)
}
