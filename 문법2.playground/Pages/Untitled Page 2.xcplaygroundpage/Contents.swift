//: [Previous](@previous)

import Foundation
import UIKit
/**
 typeCasting
 - 형변환 -> 타입캐스팅,/타입변환
 - 타입캐스팅: 인스턴스 타입을 확인하거나 인스턴스 자신의 타입을 다른 타입의 인스턴스인것처럼 사용
 */


let a = 2
let value = String(a) // 이니셜라이저 구문통해 새롭게 인스턴스를 생성한것 = 형변환
type(of: a) //int
type(of: value) //string

// 애플구글모바일
class Mobile {
    let name: String
    var introduce: String {
        return "\(name)입니다"
    }
    init(name: String) {
        self.name = name
    }
}

class Google: Mobile {}
class Apple: Mobile {}

let mobile = Mobile(name: "phone")
let apple = Apple(name: "apple")
let google = Google(name: "google")

// is : 어떤클래스의 인스턴스 타입,데이터타입인지 확인
mobile is Mobile // true
mobile is Apple // false
mobile is Google // false

apple is Mobile // true
apple is Apple // true
apple is Google // true


//Local Notification: as(앱캐스팅) / as? as! (다운캐스팅)
let iphone: Mobile = Apple(name: "APPLE") //wwdc 프로퍼티 접근 불가능

//as? 옵셔널 반환 타입 -> 실패할경우 nil반환
//as! 옵셔널 x -> 실패할경우 무조건 런타임오류발생
if let value = iphone as? Apple {
    print(value)
} else {
    print("타입캐스팅실패")
}
// iphone as! Google 런타임 오류 발생
apple as Mobile

// Any vs Anyobject
//Any: 모든타입에대해 인스턴스 담을수있음
//Anyobject: 클래스의 인스턴스만 담을수읶ㅆ음.
//공통점: 컴파일 시점에선 어떤타입인지 알수없고, 런타임 시점에서 타입이 결정
var someAny: [Any] = []
someAny.append(0)
someAny.append(true)
someAny.append("string")
someAny.append(mobile)
print(someAny) //모든 타입이 담김

let example = someAny[1]
if let element = example as? Bool { // example은 Any, example as? Bool은 Bool
    print(element)
} else{
    print("bool아님")
}


var someAnyThing: [AnyObject] = [] //
//someAnyThing.append(0) //오류
//someAnyThing.append(true) //오류
//someAnyThing.append("string") //오류
someAnyThing.append(mobile)
print(someAnyThing) //모든 타입이 담김

let example2 = someAnyThing[0]
if let element = example2 as? String { // example은 Any, example as? Bool은 Bool
    print(element.count)
} else{
    print("bool아님")
}

let name: String? = "abc"

/**
 재네릭
 타입에 유연하게 대응
 Jack: 타입파라미터로 플레이스 홀더(Placeholder)같은 역할, 어떤타입인지 타입종류는 알려주지않음, 특정한 타입하나라는건 알수있음, 재네릭으로 이루어진 함수사용시
 T에 들어갈 타입은 모두 같아야한다. 주로 대문자씀. ex) T , U , K
 
 - type constraints: 클래스/프로토콜 제약
 */
func configureBorderLabel(_ view: UILabel) {
    view.backgroundColor = .clear
    view.layer.cornerRadius = 8
    
}
func configureBorderTextField(_ view: UITextField) {
    view.backgroundColor = .clear
    view.layer.cornerRadius = 8
}
func configureBorderButton(_ view: UIButton) {
    view.backgroundColor = .clear
    view.layer.cornerRadius = 8
}
func configureBorder<T: UIView>(_ view: T) {
    view.backgroundColor = .clear
    view.layer.cornerRadius = 8
}
let img = UIImageView()
let lbl = UILabel()
configureBorder(lbl)
configureBorder(img)

struct DummyData<T> {
    var name: T
}


let data = DummyData(name: "abc")
let intData = DummyData(name: 444)



func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

total(a: [1,2,3,4,5])
total(a: [4.3,2.4,2.3])

//화면전환코드
class SampleViewController: UIViewController{
    
    func transitionViewController<T: UIViewController>(sb: String, vc: T) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: String(describing: vc)) as! T
        self.present(vc,animated: true)
    }
}

struct DymmyData2<T, U> {
    var mainContents: T
    var subContents: U
}
let cast = DymmyData2(mainContents: "현빈", subContents: "주인공역")

class Animal {
    var name: String
    init(name: String) {
        self.name = name
    }
}
let cat = Animal(name: "고양이")
let dog = Animal(name: "개")

var fruit1 = "사과"
var fruit2 = "바나나"
swap(&fruit1,&fruit2) // inout parameter
print("fruit1:",fruit1,"fruit2:",fruit2)

func swapTwoInts<T>(a: inout T, b: inout T) {
    let temp = a
    a = b
    b = temp
}
swapTwoInts(a: &fruit1, b: &fruit2)
print("fruit1:",fruit1,"fruit2:",fruit2)
