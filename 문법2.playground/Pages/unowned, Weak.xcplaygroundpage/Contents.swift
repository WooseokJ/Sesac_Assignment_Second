import UIKit


class Guild {
    var name: String
    weak var owner: User? //길드장은 누구?
    
    init(name: String) {
        self.name = name
        print("guild init")
    }
    
    deinit {
        print("guild deinit")
    }
    
}


class User {
    var name: String
    var guild: Guild? //고래밥이 새싹길드에있다면?
    
    init(name: String) {
        self.name = name
        print("user init")
    }
    
    deinit {
        print("user deinit")
    }
}


//처음엔 RC 0
var user: User? = User(name: "고래밥") // User: RC 1 인스턴스 생성시 메모리에올라감 init
var guild: Guild? = Guild(name: "새싹") //  Guild: RC(refrence count) 1


user?.guild = guild // Guild: RC 2
guild?.owner = user // User: RC 2

user = nil // User: RC 2
//guild = nil // Guild: RC 1

//user?.guild
guild?.owner// 메모리주소

// 순환참조중인 요소를 먼저 nil, 인스턴스 참조관계 먼저해제 -> 어렵다 -> weak un
//user?.guild = nil // Guild: RC 2 -> 1 //앱에서 더이상 사용하지않을떄
//guild?.owner = nil// User: RC 0(2 -> 1) // RC 가 0 이되면 deinit실행 // 먼저 없애겟다  User: RC 2     owner에대한 rc가 증가하지않음
