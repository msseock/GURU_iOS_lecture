//
//  ViewController.swift
//  FireStoreBasic
//
//  Created by swuad_21 on 2021/07/19.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var noteField: UITextField!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        // 문서 설정
        // noteRef로 DocumentReference 설정
        let noteRef = db.collection("notes").document("msg")
        // 단일 문서를 만들거나 덮어쓰기 위한 set() 메서드
        noteRef.setData([
            "text": "sample text",
            "sendTime": FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        
    }

    @IBAction func doSend(_ sender: UIButton) {
        // 서버에 데이터 쓰기
        let noteRef = db.collection("notes").document("msg")
        if let text = noteField.text {
            noteRef.setData([
                "text": "\(text)",
                "sendTime": FieldValue.serverTimestamp()
            ])
            self.noteField.text = ""
        }
    }
    
}

