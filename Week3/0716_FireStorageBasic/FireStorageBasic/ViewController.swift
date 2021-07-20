//
//  ViewController.swift
//  FireStorageBasic
//
//  Created by swuad_21 on 2021/07/20.
//

import UIKit
import FirebaseStorage
import Photos


class ViewController: UIViewController {
    let storage = Storage.storage()
    var storageRef:StorageReference!
    var imagePicker:UIImagePickerController!
    var file_name:String!
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        storageRef = storage.reference()
        
    }

    // 어떤 기능을 구현하고 싶다
    // 기능을 세분화해서 단계를 나눈다
    
    @IBAction func selectImage(_ sender: UIButton) {
        print("select Image")
        
        // actionSheet 만들기
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 취소 버튼 추가
        let action_cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) // 거기에 추가될 action 목록
        actionSheet.addAction(action_cancel) // 추가
        
        // 갤러리 버튼 추가
        let action_gallery = UIAlertAction(title: "Gallery", style: .default) { (action) in
            print("push gallery button")
            
            // 갤러리 접근 권환 얻기 프로세스
            switch PHPhotoLibrary.authorizationStatus() {
            case .authorized:
                print("접근 가능")
                self.showGallery()
            case .notDetermined:
                print("권한 요청한 적 없음")
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
                    
                }
            default:
                let alertVC = UIAlertController(title: "권한 필요", message: "사진첩 접근 권한이 필요합니다. 설정 화면에서 설정해주세요.", preferredStyle: .alert)
                let action_settings = UIAlertAction(title: "Go Settings", style: .default) {
                    (action) in
                    print("go settings")
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                    }
                }
                let action_cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertVC.addAction(action_settings)
                alertVC.addAction(action_cancel)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
        actionSheet.addAction(action_gallery)
        
        
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        guard let image = imageView.image else {
            let alertVC = UIAlertController(title: "알림", message: "이미지를 선택하고 업로드 기능을 실행하세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        print("이미지 있음")
        if let data = image.pngData() {
            print("process 1")
            let imageRef = storageRef.child("images/\(file_name!).png")
            print("process 2")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            // Upload the file to the path "images/\(file_name).png"
            let uploadTask = imageRef.putData(data, metadata: metadata) { (metadata, error) in
                print("process 3")
                
                if let error = error {
                    debugPrint(error)
                    return
                }
                guard let metadata = metadata else {
                    return
                }
                
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }
                    print(downloadURL, "upload complete")
                }
            }
        }
    }
}

extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showGallery() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        if let url = info[.imageURL] as? URL {
            file_name = (url.lastPathComponent as NSString).deletingPathExtension
            print(file_name, "filename")
        }
        
        imageView.image = selectedImage
    }
}
