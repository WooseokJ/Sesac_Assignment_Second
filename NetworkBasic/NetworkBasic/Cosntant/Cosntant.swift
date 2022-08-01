import Foundation

//MARK: 방법1
//enum StoryBoardName: String {
//    case Main
//    case Search
//    case Setting
//}
//StoryBoardName.Main // 길어!!!

//MARK: 방법2
//struct StoryBoardName {
      //접근 제어를통해 초기화방지
//      private init(){ //private은 이 구조체 내에서만 사용가능
      
//      }
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}
//StoryBoardName.main //사용위치가 알맞지않아서 오류난거니 무시


/*
 비교1.struct에서 타입프로퍼티 vs 열거형에서 타입프로퍼티 => 구조체와 열거형의 차이: 인스턴스 생성 방지
 비교2.열거형에서 (case vs static) => case는 중복된raw값을 쓸수없으므로 static을 사용하는것
 */



//MARK: 방법3(가장권장) (방법1+2 합친거)
enum StoryBoardName {
    //    var nickname = "고래밥" //사용불가(열거형은 인스턴스 못만들어서(초기화안됨))
    static let main = "Main"    //사용가능
    static let search = "Search"
    static let setting = "Setting"
}

//MARK: 비교2
//enum FontName: String {
//    case title = "SanFansisco"
//    case body = "SanFansisco" // enum case에선 같은값을갖을수없다.즉, 중복된값을 쓸수없다.
//    case caption = "AppleSchool"
//}
