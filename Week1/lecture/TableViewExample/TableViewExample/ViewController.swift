//
//  ViewController.swift
//  TableViewExample
//
//  Created by 석민솔 on 2021/07/08.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var datasource:[String] = []
    @IBOutlet weak var memoText: UITextField!
    // var datasource = [String][] 위와 같음
    
    // 뷰 인스턴스가 메모리에 올라왔고, 아직 화면은 뜨지 않은 상황
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 새로고침
        let refreshControl = UIRefreshControl()
//        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        let userDefault = UserDefaults.standard
        if let value = userDefault.array(forKey: "MemoData") as? [String] {
            print(value, "from User Default")
            self.datasource = value
        }
    }
    
    @objc func fetchData(_ sender:Any) {
        tableView.refreshControl?.endRefreshing()
    }

    // 나타나기 직전(메인화면에서 숨겼다가)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // 사라지기 직전(다음 화면에서 네비게이션 바 나타나도록)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func addMemo(_ sender: Any) {
        guard let memo = memoText.text, memo != "" else {
            return
        }
        // 변수에 저장
        print(memo)
        self.datasource.append(memo)
        memoText.text = ""
        
        // UserDefaults에 저장
        saveData()
        tableView.reloadData()
    }
    
    func saveData() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(datasource, forKey: "MemoData")
        userDefault.synchronize()
    }
}


extension ViewController: UITableViewDataSource {
    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    // 셀 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! memoCell
        let row = indexPath.row
        cell.memoLabel.text = "\(datasource[row])"
        cell.numLabel.text = "\(row+1)"
        return cell
    }
    
    // 지우기 컨트롤(canEditRowAt)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 이동가능여부(canMoveRowAt)
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true // 움직일 수 있음
    }
    
    // 실제 데이터 이동시키기
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = sourceIndexPath.row
        let toRow = destinationIndexPath.row
        let data = datasource[fromRow]
        datasource.remove(at: fromRow)
        datasource.insert(data, at: toRow)
        saveData()
        tableView.reloadData()
        
    }
    
    // Edit 버튼과 연결, 수정 가능과 불가능 여부 바꿈
    @IBAction func changeEditing(_ sender: UIBarButtonItem) {
        // toogle swift 4.2 추가됨
        self.tableView.isEditing.toggle()
    }
}


extension ViewController:UITableViewDelegate {
    // editingStyleForRowAt(canEditRowAt 버튼 스타일)
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // shouldIndentWhileEditingRowAt: 들여쓰기 여부
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // 셀에서 스와이프했을 때 오른쪽 끝에 나타날 버튼들(trailingSwipeActionsConfigurationForRowAt)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Edit
        let btnEdit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            // 값 수정을 위한 alert 창
            let editAlert = UIAlertController(title: "Edit Memo", message: "change your memo", preferredStyle: .alert)
            // 수정할 값 입력하는 textfield
            editAlert.addTextField { (textField) in
                textField.text = self.datasource[indexPath.row]
            }
            // modify 버튼
            editAlert.addAction(UIAlertAction(title: "Modify", style: .default, handler: { (action) in
                if let fields = editAlert.textFields, let textField = fields.first, let text = textField.text {
                    print(text)
                    self.datasource[indexPath.row] = text
//                    self.tableView.reloadData() : 전체 데이터 불러오기
                    self.tableView.reloadRows(at: [indexPath], with: .fade) // 한 줄만 업데이트
                    self.saveData()
                }
            }))
            // cancel 버튼
            editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(editAlert, animated: true, completion: nil)
            completion(true)
        }
        // Del
        let btnDelete = UIContextualAction(style: .destructive, title: "Del") { (action, view, completion) in
            
            // 데이터에서 지움
            let row = indexPath.row
            self.datasource.remove(at: row)
            
            // 화면(table view)에서 지움
//            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
            self.saveData()
            
            completion(true)
        }
        
        btnEdit.backgroundColor = .blue
        btnDelete.backgroundColor = .black // UIColor.black과 같음!
        return UISwipeActionsConfiguration(actions: [btnDelete, btnEdit])
    }
    
    // 셀 왼쪽 시작부분에 나타날 버튼들(leadingSwipeActionsConfigurationForRowAt)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnShare = UIContextualAction(style: .normal, title: "Share") { (action, view, completion) in
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [btnShare])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "goDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 12
    }
}
