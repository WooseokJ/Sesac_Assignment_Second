//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//값 전달 프로토콜로 활용

protocol MyDelegate: AnyObject {
    func sendData(_ date: String)
}

class Main: MyDelegate {
    
    lazy var detail: Detail = {
       let view = Detail() // 인스턴스
        view.delegate = self // self는 Main
        return view
    }()
    
    func sendData(_ date: String) {
        print("\(date)를 전달받음.")
    }
    
    init() {
        print("Main init")
    }
    deinit {
        print("Main deinit")
    }
    
}


class Detail {
    var delegate : MyDelegate? // Main에서 delegate로 인해 Main의 인스턴스가 들어옴.    + RC1  .  타입으로서의 프로토콜, 클래스인스턴스가 들어올수이씅ㅁ.
    func dismiss() {
        delegate?.sendData("안녕")
    }
    
    init() {
        print("Detail init")
    }
    deinit {
        print("Detail deinit")
    }
}


var main: Main? = Main() // RC 1
main?.detail // RC 2
main = nil // RC  1

var ex: MyDelegate = Main()

