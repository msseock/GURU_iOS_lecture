//
//  ViewController.swift
//  PracticeSpreadsheetView
//
//  Created by 석민솔 on 2021/07/22.
//

import UIKit
import SpreadsheetView

class ViewController: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    private let spreadsheetView = SpreadsheetView()
    
    let data = [
        // 이 부분이 더 복잡해질 것 같다. 구글에 요청해서 받아온 정보를 저장(이걸 데이터베이스로 하는 방식 가능!?)
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spreadsheetView.register(MyLabelCell.self, forCellWithReuseIdentifier: MyLabelCell.identifier)
        spreadsheetView.gridStyle = .solid(width: 1, color: .link)
        spreadsheetView.delegate = self
        spreadsheetView.dataSource = self // 스프레드 시트에 들어가는 내용 지정해주기
        view.addSubview(spreadsheetView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spreadsheetView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height-100)
    }
    
    // 여기서 들어가는 내용 채울 수 있다
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: MyLabelCell.identifier, for: indexPath) as! MyLabelCell
        
        if indexPath.section == 0 {
            // first column
            cell.setup(with: data[indexPath.row])
            cell.backgroundColor = .systemGreen
        } else {
            cell.setup(with: "Enter Task")
        }
        return cell
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 300
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return data.count
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 200
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 55
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

class MyLabelCell:Cell {
    
    static let identifier = "MyLabelCell"
    
    private let label = UILabel()
    
    public func setup(with text:String) {
        label.text = text
        label.textAlignment = .center
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}
