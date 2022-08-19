
import Foundation
import UIKit

class BaseView: UIView {
    
    //코드베이스일떄
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstrains()
    }
    // xib, 스토리보드일떄 이니셜라이저(init) 호출 (프로토콜기반)
    required init?(coder: NSCoder) { // 프로토콜떄문에 어쩔수없이 호출
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented") //런타임에러 
    }
    
    func configureUI() {
        
    }
    func setConstrains() { }
    
}



//아래부분은 화면띄우는거랑 상관없음.
// required 이니셜라이저
protocol example {
    init(name: String) // 항상 name호출해야해
}

class Mobile: example { //  example이 NSCoder뜻함
    let name : String
    required init(name: String) {
        self.name = name
    }
}

class Apple: Mobile { // Mobile 이 UIView와 비슷한상황
    let wwdc: String
    init(wwdc: String) {
        //순서중요 자식꺼다하고 부모꺼해야함.
        self.wwdc = wwdc
        super.init(name: "모바일")
    }
    
    required init(name: String) {
      
        fatalError("init(name:) has not been implemented") // 런타임 에러(디버깅에 보임)
    }
    
}
let a = Apple(wwdc: "애플")

// uiview - init(frame) -> 코드베이스 호출
// uiview - required init(coder) -> 스토리보드,xib 호출
