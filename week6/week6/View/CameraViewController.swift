//
//  CameraViewController.swift
//  week6
//
//  Created by useok on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON
import YPImagePicker
class CameraViewController: UIViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var name : String?
    
    //UIImagePickerController
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIImagePickerController2
        picker.delegate = self
        
        
        
    }
    //오픈소스로 구현한 카메라
    //권한문구들도 내부적으로 구현,실제카메라쓸떄 권한으로 요청
    @IBAction func YPImagePickerButtonClicked(_ sender: UIButton) {
        let picker = YPImagePicker() //권한요청 메소드는 안에있어.
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil  , 편집된이미지
                print(photo.exifMeta) // Print exif meta data of original image.
                self.resultImageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    //일반카메라
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { // .camera
            print("사용불가+사용자에게 토스트/얼럿띄움")
            return
        }
        picker.sourceType = .camera //카메라로 띄우겟다 // photolibrary로하면 갤러리가 뜸 camera하면 camera뜸
        picker.allowsEditing = true // 카메라 찍은뒤 편집할수있냐없냐 default는 false임. //이게있어서 찍은뒤 편집화면이 보일수있는거
        present(picker, animated: true)
        
    }
    
    //갤러리
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { // .camera
            print("사용불가+사용자에게 토스트/얼럿띄움")
            return
        }
        picker.sourceType = .photoLibrary //카메라로 띄우겟다 // photolibrary로하면 갤러리가 뜸 camera하면 camera뜸
        picker.allowsEditing = true // 카메라 찍은뒤 편집할수있냐없냐 default는 false임. //이게있어서 찍은뒤 편집화면이 보일수있는거
        present(picker, animated: true)
    }
    
    //이미지 저장하기
    @IBAction func saveToPhotoLibaray(_ sender: UIButton) {
        if let image = resultImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    // 이미지 뷰 이미지 -> 네이버 -> 얼굴분석해줘요청 -> 응답
    //문자열아닌 파일,이미지 ,pdf파일 자체가 그대로 전송되지않음 -> 텍스트형태로 인코딩
    // 어떤 파일종류가 서버에 전달되는지 명시 -=> content - type
    @IBAction func clovaFaceButtonClicked(_ sender: UIButton) {
        print("ddd")
        let url = "https://openapi.naver.com/v1/vision/celebrity"
        let header : HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SECRET
//            "Content-Type": "multipart/form-data" //라이브러리 내장되있음
        ]
        guard let imageData = resultImageView.image?.jpegData(compressionQuality: 0.5) else {return}
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image")
           
        }, to: url, headers: header)
        .validate(statusCode: 200...500).responseData{ [self] response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                print(json)
                name = json["faces"][0]["celebrity"]["value"].stringValue
                nameLabel.text = name!
            case .failure(let error):
                print(error)
            }
        }
       
    }
    
}

//UIImagePickerController3
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //UIImagePickerController4 : 사진성택하거나 카메라 촬영직후
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("가가")
        // 원본,편집,메타데이터등 - infokey
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // 위에서 true기떄문에 동작됨. 원랭는 allediting이 false기떄문에 originalImage로 해야지 이미지 편집이 가능하다 참고로 false이면 editedImage는 nil이된다.
            self.resultImageView.image = image
            dismiss(animated: true)
        }
        
    }
    //UIImagePickerController5: 취소버튼 클릭시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("나난")
        dismiss(animated: true)
    }
}
