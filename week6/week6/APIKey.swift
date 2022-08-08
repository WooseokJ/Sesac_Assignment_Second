import Foundation

// enum 초기화 구문 X
// apikey -> 다른컴퓨터에서 프로젝트 작업하면? -> key 파일이 없으니 불편.. 그래서 key만뺴는방법이있다.
//    ==>>> property list -> API configuration

enum APIKey { //struct, enum 둘다 상관없지만 enum 추천
    static let kakao = "a2fd13462b5ac3e7ddc24cd03dd87109"
}
