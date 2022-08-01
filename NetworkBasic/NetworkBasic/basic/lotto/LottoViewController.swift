//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by useok on 2022/07/28.
//

import UIKit // 내부 애플라이브러리

import Alamofire // 알파벳순으로 외부라이브러리
import SwiftyJSON


class LottoViewController: UIViewController {
    
    //viewcontroller에서도 UIpickerview를 불러와서 쓸수있음.
//    @IBOutlet weak var lottoPickerView: UIPickerView!
  
    var lottoPickerView = UIPickerView()
    
    @IBOutlet weak var numberTextField: UITextField!
    
    let numberList : [Int] = Array(1...1025).reversed() // 역순정렬
   
    
    @IBOutlet var lottoNoLabel: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        numberTextField.textContentType = .oneTimeCode //이건 인증번호로 자동완성띄우기
        
        
        numberTextField.tintColor = .clear // 커서깜빡이는거 없어짐
        numberTextField.inputView = lottoPickerView // 텍스트필드 클릭시 키보드가 올라오지않음.(피커뷰 올라옴)   , 텍스트필드,뷰에만있음(키보드대신해서사용)
        
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        requestLotto(number: 1025)
      
    }
    
  
    
    func requestLotto(number: Int) {
        
        // AF: 200~299 를 성공(status code 가 success)
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
//                let bonuse = json["bnusNo"].intValue //int 와 intValue는 옵셔널차이
                
                let drwNo = json["drwNo"].stringValue
                
                
                self.numberTextField.text = drwNo+"회" //날짜를 텍스트필드에 보여줄게
                
                var cnt = 1
                for num in self.lottoNoLabel{
                    num.textAlignment = .center
                    self.colorBackGround(target: num)
                    guard num != self.lottoNoLabel[self.lottoNoLabel.count-1] else {
                        num.text = json["bnusNo"].stringValue
                        return
                    }
                    num.text = json["drwtNo\(cnt)"].stringValue
                    cnt+=1
                }
   
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
extension LottoViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    
    //MARK: 피커 세로 선택 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 4
    }
    
    //MARK: 피커안의 내용 선택개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return component == 0 ? 10 : 20
        // componet는 피커의 왼쪽부터의 위치
        // 왼쪽끝만 0~9 사이의 값 피커가능(10개),
        // 나머지는 0~19 사이 -값 피커가능(20개)
        
//        return 1024 //1025회가 최근일기준
        
        return numberList.count
    }
    
    //MARK: 피커선택시
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("componet:",component,"row",row)
//        numberTextField.text = "\(row+1)회차"
        requestLotto(number: numberList[row])
//        numberTextField.text = "\(numberList[row])회차"
    }

    //MARK: 피커안의내용(제목)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "\(row+1)번쨰 임" // 피커에 보이는 글자
        return "\(numberList[row])회차 임"
    }
    func colorBackGround(target: UILabel){
        let r : CGFloat = CGFloat.random(in: 0.5...1)
        let g : CGFloat = CGFloat.random(in: 0.5...1)
        let b : CGFloat = CGFloat.random(in: 0.5...1)
        target.backgroundColor = UIColor(red : r,green: g,blue: b,alpha: 1)
    }
   
}
