
import Foundation
import UIKit

extension UIViewController {
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil} //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지 저장할 위치
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지 저장할 위치
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지 저장할 위치
        guard let data = image.jpegData(compressionQuality: 0.5) else { return } //용량줄이기
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
}
