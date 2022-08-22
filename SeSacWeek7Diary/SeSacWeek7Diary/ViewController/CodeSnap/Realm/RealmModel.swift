import Foundation
import RealmSwift // Realm을 스위프트로 사용할수있게 만듬.

//Userdiary: 테이블명
// @persisted: 칼럼
class Userdiary: Object {
    @Persisted var diaryTitle: String // 제목(필수) //만약 pk이면 중복되는제목 사용불가
    @Persisted var diaryContent: String? // 내용(옵션)  //인덱스 등록해두면 속도가 빨라짐. (책에서 책갈피같다고보면됨) 너무많이 등록하면 속도느려짐.
    @Persisted var diaryDate = Date() // 작성날짜(필수)
    @Persisted var regdate = Date() // 등록날짜(필수)
    @Persisted var favorite: Bool // 즐겨찾기(필수)
//    @Persisted var like: Bool // 학습위해추가
    @Persisted var photo: String? // 사진(옵션)
    
    
    // pk지정(중복x 필수) : Int,UUID(데이터 고유한 식별자로 16바이트길이의 숫자로),objectID(데이터 고유한 식별자로 12바이트길이의 숫자로)
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    //편의생성자(초기화)
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: Date, regdate: Date, photo: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.regdate = regdate
        self.favorite = false
//        self.like = false
        self.photo = photo
        
    }
    
}

// 참고
// https://www.mongodb.com/docs/realm/sdk/swift/model-data/define-model/supported-types/
// https://www.mongodb.com/docs/realm/sdk/swift/model-data/define-model/object-models/
// https://www.mongodb.com/docs/realm/sdk/swift/quick-start/
// https://www.mongodb.com/docs/realm/studio/open-realm-file/
