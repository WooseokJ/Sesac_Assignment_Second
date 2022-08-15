

import Foundation
import UIKit

import Kingfisher
extension UILabel {
    
    // 날짜 라벨 디자인
    func datelabelDesign(text: String) {
        self.text = text
    }
    // 위치 라벨 디자인
    func locationLabelDesign(text: String) {
        self.text = text
    }
    // 온도 라벨 디자인
    func tempLabelDesign(text: Double) {
        self.text = "지금은 \(String(format: "%.2f",text))°C 에요."
    }
    // 습도 라벨 디자인
    func humidityLabelDesign(text: String) {
        self.text = "\(text)% 만큼 습해요."
    }
    // 풍량 라벨 디자인
    func windyLabelDesign(text: String) {
        self.text = "\(text)m/s의 바람이 불어요."
    }
    // 좋은날 라벨 디자인
    func niceDayLabelDesign() {
        self.text = "오늘도 행복한 하루 보내세요."
    }
}

extension UIButton {
    func ButtonDesign(imageName: String) {
        self.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

extension UIView {
    func backUIViewDesign() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
    }
}

extension UIImageView {
    // 이미지 디자인
    func imageViewDesign(text: String) {
        let url = URL(string: text)
        self.kf.setImage(with:url)
        self.contentMode = .scaleToFill
    }

}
