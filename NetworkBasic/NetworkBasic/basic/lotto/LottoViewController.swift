//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by useok on 2022/07/28.
//

import UIKit

class LottoViewController: UIViewController{
    
    //viewcontroller에서도 UIpickerview를 불러와서 쓸수있음.
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    var lottoPickerView = UIPickerView()
    
    @IBOutlet weak var numberTextField: UITextField!
    

    
    let numberList : [Int] = Array(1...1025).reversed() // 역순정렬
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.tintColor = .clear // 커서깜빡이는거 없어짐
        numberTextField.inputView = lottoPickerView // 텍스트필드 클릭시 키보드가 올라오지않음.(피커뷰 올라옴)   , 텍스트필드,뷰에만있음(키보드대신해서사용)
        
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
      
    }
}

extension LottoViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    
    //피커 세로 선택 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 4
    }
    // 피커안의 내용 선택개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return component == 0 ? 10 : 20
        // componet는 피커의 왼쪽부터의 위치
        // 왼쪽끝만 0~9 사이의 값 피커가능(10개),
        // 나머지는 0~19 사이 -값 피커가능(20개)
        
//        return 1024 //1025회가 최근일기준
        
        return numberList.count
    }
    
    //피커선택시
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("componet:",component,"row",row)
//        numberTextField.text = "\(row+1)회차"
        numberTextField.text = "\(numberList[row])회차"
    }

    //피커안의 내용(제목)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "\(row+1)번쨰 임" // 피커에 보이는 글자
        return "\(numberList[row])회차 임"
    }
}