//
//  ViewController.swift
//  TableViewExample
//
//  Created by 석민솔 on 2021/07/08.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [1, 2, 3, 4, 5]
    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    // 셀 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        cell.textLabel?.text = "\(datasource[row])"
        return cell
    }
    
    // editingStyleForRowAt
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // shouldIndentWhileEditingRowAt
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // 지우기 컨트롤(canEditRowAt)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 이동가능여부(canMoveRowAt)
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true // 움직일 수 있음
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = sourceIndexPath.row
        let toRow = destinationIndexPath.row
        let data = datasource[fromRow]
        datasource.remove(at: fromRow)
        datasource.insert(data, at: toRow)
        tableView.reloadData()
        
    }
    
    // 셀에서 스와이프했을 때 오른쪽 끝에 나타날 버튼들(trailingSwipeAction~)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnDelete = UIContextualAction(style: .destructive, title: "Del") { (action, view, completion) in
            
            // 데이터에서 지움
            let row = indexPath.row
            self.datasource.remove(at: row)
            
            // 화면(table view)에서 지움
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completion(true)
        }
        
        btnDelete.backgroundColor = .black // UIColor.black과 같음!
        return UISwipeActionsConfiguration(actions: [btnDelete])
    }

    // 셀 왼쪽 시작부분에 나타날 버튼들(leadingSwipeActions~)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnShare = UIContextualAction(style: .normal, title: "Share") { (action, view, completion) in
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [btnShare])
    }
    
    override func viewDidLoad() {
        // 뷰 인스턴스가 메모리에 올라왔고, 아직 화면은 뜨지 않은 상황
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.isEditing = true // 테이블이 편집이 가능한 상태
    }

    
}

