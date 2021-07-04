//
//  ViewController.swift
//  Memo
//
//  Created by 석민솔 on 2021/07/05.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    var memoNumbers = Array<String>()
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // tableview에 띄우기, DB에 저장하기
    @IBAction func doSave(_ sender: Any) {
        NSLog("save")
        
        // 입력한 텍스트값 받아오기
        if let text = textField.text {
            // table view에 띄우기
            memoNumbers.append(text)
        }
        // 키보드 없애기
        view.endEditing(true)
    }
    
    @IBAction func textFieldEndEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func textEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 셀 몇개?
        return memoNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀에 내용 넣어서 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! MemoCell
        return cell
    }
    
    
}
