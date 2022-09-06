//: [Previous](@previous)
// editor -> show raw markup
import Foundation


class User {
    var nickName = "Jack"
    
    lazy var introduce: () -> String = { // [weak self] in // weak self 하면 self를 써도 Rc가 안올라감.
        return "나는 \(self.nickName )이다" //self.를 쓰는순간  RC +1 이 된다.
//        return "나는"    // self없으므로 RC 안올라감.
    }
    
    init() {
        print("User init")
    }
    
    deinit {
        print("User deinit")
    }
}

var user: User? = User() // RC 1
user?.introduce // RC 2
user = nil // RC 1


func myClosure() {
    
    var num = 0
    print("1 \(num)")
    
    let closure: () -> Void = {
        print("closure: \(num)")
    }
    closure()
    
    num = 100
    print("2 \(num)")
    closure()
    
}
myClosure()
