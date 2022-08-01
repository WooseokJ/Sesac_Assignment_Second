//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by useok on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController {

    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTextView: UITextView!
    @IBOutlet weak var beerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        randomButton.setTitle("랜덤뽑기", for: .normal)
        randomBeerTake()

    }
    func randomBeerTake() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)  // 받아온 데이터를 JSON으로 변환하여 json 변수에 저장
                print("JSON: \(json)")
                //맥주 이름
                beerNameLabel.text = json[0]["name"].stringValue
                
                //맥주 설명
                beerTextView.text = json[0]["description"].stringValue
                
                //맥주이미지
                let imageurl = URL(string: json[0]["image_url"].stringValue)
                beerImageView.kf.setImage(with:imageurl)
                
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func randomButtonClicked(_ sender: UIButton) {
        randomBeerTake()
    }
}




