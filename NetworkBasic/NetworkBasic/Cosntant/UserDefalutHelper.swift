import Foundation

class UserDefalutHelper { //struct도 가능하지만 class로쓰는게 적합
    
    static let standard = UserDefalutHelper() // 우리가만든 싱글턴패턴 인스턴스(UserDefalutHelper) 타입프로퍼티(standard)
    
    // 싱글턴패턴 : 자기자신의 인스턴스(UserDefaluts)를 타입프로퍼티(standard) 형태로 갖고있음.(애플에서 만들어둠)
    let userDefaults = UserDefaults.standard
    
    enum Key: String{
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue,forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue) //오류안나는이유: Int는 defalut가 0으로 들어가있어서 String은 defalut 없음.
        }
        set {
            userDefaults.set(newValue,forKey: Key.age.rawValue)
        }
    }
}
