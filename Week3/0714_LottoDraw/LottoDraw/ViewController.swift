//
//  ViewController.swift
//  LottoDraw
//
//  Created by 석민솔 on 2021/07/04.
//

import UIKit
import FMDB
import FirebaseDatabase

class ViewController: UIViewController {
    var lottoNumbers = Array<Array<Int>>()
    var ref: DatabaseReference!
    var refHandle : DatabaseHandle!

    // 데이터베이스 경로 저장
    var databasePath = String()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // FMDB
        self.initDB()
        // Firebase
        ref = Database.database().reference()
    }
    
    func initDB() {
        // 데이터 파일 저장할 위치 잡기
        let fileMgr = FileManager.default   // 현재 켜져있는 앱 시스템에서 공유 파일에 접근할 수 있도록 해주는 메소드
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)   // 현재 사용자에게 파일을 저장할 권한이 있는 폴더 목록들이 반환
        let docDir = dirPaths[0]    // 접근할 폴더 추출(위치 잡기)
        
        databasePath = docDir + "/lotto.db"
        if !fileMgr.fileExists(atPath: databasePath) {
            // DB 만들기
            let db = FMDatabase(path: databasePath)
            if db.open() {
                // 테이블을 만들기
                // SQL: 질의문
                // 글자를 저장하기 위한 컬럼 타입: text
                let query = "create table if not exists lotto(id integer primary key autoincrement, num1 integer, num2 integer, num3 integer, num4 integer, num5 integer, num6 integer)"
                if !db.executeStatements(query) {
                    NSLog("디비 생성 실패")
                } else {
                    NSLog("디비 생성 성공")
                }
            }
        } else {
            NSLog("DB파일 있음")
        }
    }
    
    @IBAction func doLoad(_ sender: Any) {
        print("DoLoad")
        lottoNumbers = Array<Array<Int>>()
        let db = FMDatabase(path: databasePath)
        if db.open() {
            let query = "select * from lotto"
            if let result = db.executeQuery(query, withArgumentsIn: []) {
                while result.next() {
                    var columnArray = Array<Int>()
                    columnArray.append(Int(result.int(forColumn: "num1")))
                    columnArray.append(Int(result.int(forColumn: "num2")))
                    columnArray.append(Int(result.int(forColumn: "num3")))
                    columnArray.append(Int(result.int(forColumn: "num4")))
                    columnArray.append(Int(result.int(forColumn: "num5")))
                    columnArray.append(Int(result.int(forColumn: "num6")))
                    
                    lottoNumbers.append(columnArray)
                }
                self.tableView.reloadData()
            } else {
                NSLog("결과 없음")
            }
        } else {
            NSLog("DB Connection Error")
        }
    }
    
    
    @IBAction func doDraw(_ sender: Any) {
        print("Draw")
        lottoNumbers = Array<Array<Int>>()
        
        var originalNumbers = Array(1...45)
        var index = 0
        for _ in 0...4 {
            originalNumbers = Array(1...45)
            var columnArray = Array<Int>()
            for _ in 0...5 {
                index = Int.random(in: 0..<originalNumbers.count)
                columnArray.append(originalNumbers[index])
                originalNumbers.remove(at: index)
            }
            columnArray.sort()
            lottoNumbers.append(columnArray)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func doSave(_ sender: Any) {
        print("Save")
        let db = FMDatabase(path: databasePath)
        if db.open() {
            try! db.executeUpdate("delete from lotto", values: [])
            var index = 0
            for numbers in lottoNumbers {
                // FMDB
                let query = "insert into lotto(num1, num2, num3, num4, num5, num6) values (\(numbers[0]), \(numbers[1]), \(numbers[2]), \(numbers[3]), \(numbers[4]), \(numbers[5]))"
                // Firebase
                self.ref.child("lotto set\(index)").setValue(["num1": numbers[0], "num2":numbers[1], "num3":numbers[2], "num4":numbers[3], "num5":numbers[4], "num6":numbers[5]])
                index += 1
                if !db.executeUpdate(query, withArgumentsIn: []) {
                    NSLog("저장 실패")
                } else {
                    NSLog("저장 성공")
                }
            }
        } else {
            NSLog("DB Connection Error")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 셀이 몇개냐?
        return self.lottoNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀에 내용을 넣어서 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "lottoCell", for: indexPath) as! LottoCell
        let numbers = self.lottoNumbers[indexPath.row]
        cell.label01.text = "\(numbers[0])"
        cell.label02.text = "\(numbers[1])"
        cell.label03.text = "\(numbers[2])"
        cell.label04.text = "\(numbers[3])"
        cell.label05.text = "\(numbers[4])"
        cell.label06.text = "\(numbers[5])"
        
        return cell
    }
    
    
}
