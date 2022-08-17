//
//  firstViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackViewWidth: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTutorialLabel()
        animateBlackView()
        
        animateImageView(name: "star.fill")
    }
    
    func animateTutorialLabel(){
        self.tutorialLabel.text = """
        일기 씁시다!
        잘써보자
        """
        self.tutorialLabel.alpha = 0
        self.tutorialLabel.numberOfLines = 0
        self.tutorialLabel.font = .boldSystemFont(ofSize: 25)
        
        UIView.animate(withDuration: 3) { //3초동안 alpha 1로 바꿈 실행
            self.tutorialLabel.alpha = 1
            self.tutorialLabel.backgroundColor = .systemGreen
        } completion: { _ in
            print("끝")
        }
    }
    
    func animateBlackView() {
        self.blackView.backgroundColor = .black
        self.blackView.alpha = 0
        UIView.animate(withDuration: 1,delay:2) { //delay:2 2초 딜레이뒤 애니메이션시작 , options의경우 알파가 0~1로 갈떄 일정한속도로 진행되는게아닌 애니메이션효과 속도 변화를 줄수도있음.
            
            //방법1
            //self.blackView.frame.size.width += 250
            //self.blackView.alpha = 1
            //self.blackView.layoutIfNeeded()
            
            //방법2
//            self.blackViewWidth.constant += 200
//            self.blackView.alpha = 1
            
            //방법3
            self.blackView.transform = CGAffineTransform(scaleX: 3, y: 0.8) //기존크기의 3배, y축 두께 , rotationAngle은 회전,
            self.blackView.alpha = 1
            
        } completion: { _ in
            print("끝")
        }

    }
    
    func animateImageView(name: String) {
        starImageView.image = UIImage(systemName: name)
        UIView.animate(withDuration: 1, delay: 0 , options: [.repeat,.autoreverse] , animations: { //.repeat은 반복,
            self.starImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.starImageView.backgroundColor = .yellow
        } ,completion: { _ in
            print("")
        })
    }


}
