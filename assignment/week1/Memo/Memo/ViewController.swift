//
//  ViewController.swift
//  Memo
//
//  Created by 석민솔 on 2021/07/05.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    var memos = Array<String>()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    // 데이터베이스 경로 저장
    var databasePath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // 데이터베이스 초기화, create table
        // DB 초기화 함수 호출
        self.initDB()
        self.loadDB()
    }
    
    func initDB() {
        // 데이터 파일 저장할 위치 잡기
        let fileMgr = FileManager.default   // 현재 켜져있는 앱 시스템에서 공유 파일에 접근할 수 있도록 해주는 메소드
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)   // 현재 사용자에게 파일을 저장할 권한이 있는 폴더 목록들이 반환
        let docDir = dirPaths[0]    // 접근할 폴더 추출(위치 잡기)
        
        databasePath = docDir + "/memo.db"
        if !fileMgr.fileExists(atPath: databasePath) {
            // DB 만들기
            let db = FMDatabase(path: databasePath)
            if db.open() {  // 접근
                // 테이블 만들기
                // SQL: 질의문
                let query = "create table if not exists memo(id integer primary key autoincrement, memoText text)"
                if !db.executeStatements(query) {
                    NSLog("DB 생성 실패")
                } else {
                    NSLog("DB 생성 성공")
                }
            }
        } else {
            NSLog("DB파일 있음")
        }
    }
    
    func loadDB() {
        NSLog("Load DB")
        memos = Array<String>()
        let db = FMDatabase(path: databasePath)
        if db.open() {
            let query = "select * from memo"
            if let result = db.executeQuery(query, withArgumentsIn: []) {
                while result.next() {
                    var columnArray = Array<String>()
                    columnArray.append(String(result.string(forColumn: "memoText")!))
                    
                    memos.append(contentsOf: columnArray)
                }
                self.tableView.reloadData()
            } else {
                NSLog("결과 없음")
            }
        } else {
            NSLog("DB Connection Error")
        }
    }

    // tableview에 띄우기, DB에 저장하기
    @IBAction func doSave(_ sender: Any) {
        NSLog("Save")
        // 키보드 없애기
        view.endEditing(true)
        
        // 입력한 텍스트값 받아오기
        if let text = textField.text, !text.isEmpty {
            // table view에 띄우기
            memos.append(text)
            self.tableView.reloadData()
            // DB에 저장
            saveDB()
        }
    }
    
    func saveDB() {
        NSLog("Save start")
        let db = FMDatabase(path: databasePath)
        if db.open() {
            do {
                let query = "insert into memo(memoText) values (?)"
                try db.executeUpdate(query, values: [memos.last!])
            } catch let error as NSError {
                NSLog("Insert Error: \(error.localizedDescription)")
            }
            NSLog("Save finished")
        } else {
            NSLog("DB Connection Error")
        }
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
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀에 내용 넣어서 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        cell.textLabel?.text = "\(self.memos[indexPath.row])"
        return cell
    }
    
    
}
