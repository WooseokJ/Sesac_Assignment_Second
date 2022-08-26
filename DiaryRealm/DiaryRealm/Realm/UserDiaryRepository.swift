
import Foundation
import RealmSwift

protocol UserDiaryRepositoryType { //만든이유:  1.어떤메서드들이 있는지 보기편하기위함.
                                    //   2.Realm테이블이 여러개가 되면 CRUD는 잇는데 같은메서드를사용하기떄문에
    func fetch() -> Results<UserDiary>
    func fetchSort(_ sort: String) -> Results<UserDiary>
    func fetchFilter() -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func deleteItem(item: UserDiary)
    func addItem(item: UserDiary)
    func fetchDate(date: Date) -> Results<UserDiary>
}

class UserDiaryRepository: UserDiaryRepositoryType {

    
    
    
    let localRealm = try! Realm() //
    // 찾아보기
    // 클래스는 싱글턴패턴을 쓰지만 구조체 싱글턴패턴 안쓰는이유는?
    //
    
    func fetch() -> Results<UserDiary> {
        // localRealm = try! Realm() 은 위에 선언된거와 차이가없음
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
    }
    
    func fetchSort(_ sort: String) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sort, ascending: true)
    }
    func fetchFilter() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'a'")
    }
    func updateFavorite(item: UserDiary) {
//        // 내풀이
//        let task = localRealm.objects(UserDiary.self)
//        task[num].favorite = !task[num].favorite
        
        // jack풀이
        try! self.localRealm.write {
//            item.favorite = !item.favorite
            item.favorite.toggle() //  true <-> false 서로 바꿔줌
            print("Realm Update Succeed, reloadRows 필요")
        }
    }
    func deleteItem(item: UserDiary) {
        try! localRealm.write{
            localRealm.delete(item) // 레코드 삭제
        }
        /// removeImageFromDocument(fileName: "\(item.objectId).jpg") //도큐먼트의 이미지 삭제 10
    }
    func addItem(item: UserDiary) {
        
    }
    func fetchDate(date: Date) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryDate >= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date)) // %@ 는 NSPredicate 서식문자같은거
    }
    
}
