import Foundation
import UIKit

// 프로토콜은 구약이지 필요한 요소를 맹세할뿐. 실질적 구현작성 X (호출당한 클래스.구조체,열거형,익스텐션에서 사용가능)
// 실질적인 구현은 프로토콜을 채택,준수한 타입이
// @objc optional -> 옵셔널리콰이어먼트 (선택적으로요청)
// 프로토콜 프로퍼티, 프로토콜 메서드
// 프로토콜 프로퍼티 : 연산,저장 프로퍼티 사용가능   무조건 var만 가능


@objc protocol ViewPresentableProtocol{ // 여기에도 @objc 붙여야함
    //프로퍼티
    var navigationTitleString:String {get set}
    var backgroundColor : UIColor {get} // 변수에값넣으면 set처럼 사용가능한이유: 만약 get만 명시햇다면 get기능만 최소한 구현되있으면된다. (그래서 필요하면 set도 구현가능(사용가능))   대신 구현하는 클래스,구조체,열거형,익스텐션은 var를못쓰고 leta만사용가능(static도 동일)
    static var identifier : String {get}
    
    //메소드
    func configureView()
    @objc optional func configureLabel() // void 생략
    @objc optional func configureTextField()
    
    
}

// 테이블뷰
@objc protocol JackTableViewProtocol{ // 필수적인 기능을 구현해야하는것은 프로토콜(상속 개수제한X)로 쓰고 클래스(단독상속)는 특정기능만 구현하는건 상속오버라이딩
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath:IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt() // 옵셔널 함수는 쓸수도있고 안쓸수도있어
}


