//
//  SpreadsheetViewController.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit
import SpreadsheetView

class SpreadsheetViewController: UIViewController {
    var isSheetLoad = false
    private let spreadsheetView = SpreadsheetView()
    
    var viewModel: SpreadsheetViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        spreadsheetView.register(SpreadsheetViewCell.self, forCellWithReuseIdentifier: SpreadsheetViewCell.identifier)
        spreadsheetView.dataSource = self

        navigationController?.navigationBar.prefersLargeTitles = false
        
        getFileProperty()
        getFiles()
        
        view.addSubview(spreadsheetView)
        self.title = viewModel.fileName
    }
    
    override func viewDidLayoutSubviews() { // 시트 레이아웃 constraint
        super.viewDidLayoutSubviews()
        
        spreadsheetView.frame = CGRect(x: 0, y: 0 , width: view.frame.size.width, height: view.frame.size.height)
    }
    
    // SheetProperties.swift를 viewModel의 getSpreadsheetProperties()를 이용해서 설정
    private func getFileProperty() {
        viewModel.getSpreadsheetProperties(withID: viewModel.driveFile.id, withToken: GoogleService.accessToken) { sheetsProperties in
            guard let properties = sheetsProperties else { return }
            print("getSpreadsheetProperties로 받아온 property들: ", properties)
//            self.viewModel.sheetsProperties = properties // sheetProperties가 완성됨
        }
    }
    
    private func getFiles() {
        viewModel.getSpreadsheetValues(withID: viewModel.driveFile.id, withToken: GoogleService.accessToken) { sheet in
            guard let sheet = sheet else { return }
            self.viewModel.sheet = sheet
            self.isSheetLoad = true
            
            DispatchQueue.main.async {
                self.spreadsheetView.reloadData()
            }
        }
    }
    
    // 서버로 시트 내용 post, addNewRow -> postSheetData
    func postSheetData(/*_ sender: Any?*/) {
        viewModel.postNewRow(withID: viewModel.driveFile.id, withToken: GoogleService.accessToken) { _ in
            self.viewModel.getSpreadsheetValues(withID: self.viewModel.driveFile.id, withToken: GoogleService.accessToken) { sheet in
                guard let sheet = sheet else { return }
                self.viewModel.sheet = sheet
                
                DispatchQueue.main.async {
                    self.spreadsheetView.reloadData()
                }
            }
        }
    }
}

// MARK: SpreadsheetViewDataSource
extension SpreadsheetViewController: SpreadsheetViewDataSource {
 
    // 셀 열 몇줄
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        let colums = viewModel.sheet?.values[1].count ?? 1
        print("시트 열 개수:", colums)
        return 70
    }
    
    // 셀 행 몇줄
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        let rows = viewModel.sheet?.values.count ?? 1
        print("행 개수", rows)
        return 100
    }
    
    // 셀 너비 widthForColumn
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if column == 0 {
            return 55
        } else {
            return (view.frame.width - 55) / 3
        }
    }
    
    // 셀 높이 heightForRow
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow column: Int) -> CGFloat {
        if column == 0 {
            return 30
        } else {
            return 30
        }
    }
    

    // 셀 고정     // 데이터 로드 전 값이 0이라서 고정 에러뜸
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }


    // 셀 내용
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let rows = viewModel.sheet?.values.count ?? 0
        let columns = viewModel.sheet?.values[1].count ?? 0
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: SpreadsheetViewCell.identifier, for: indexPath) as! SpreadsheetViewCell

        // 행렬 좌표명 & 기본 셀 설정
        if indexPath.row == 0 && indexPath.column == 0 { // 첫번째 셀
            cell.setupDefault(with: " ")
            cell.backgroundColor = #colorLiteral(red: 0.187317878, green: 0.1923363805, blue: 0.2093544602, alpha: 1)
        } else if indexPath.row == 0 {  // 첫 열 1~N
            cell.setupDefault(with: "\(UnicodeScalar(indexPath.column + 64)!)")
            cell.backgroundColor = #colorLiteral(red: 0.187317878, green: 0.1923363805, blue: 0.2093544602, alpha: 1)
        } else if indexPath.column == 0 {  // 첫 행 A~N
            cell.setupDefault(with: "\(indexPath.row)")
            cell.backgroundColor = #colorLiteral(red: 0.187317878, green: 0.1923363805, blue: 0.2093544602, alpha: 1)
        } else {
            cell.setup(with: "")
        }
        
        // 로드되면 데이터 넣기
        if self.isSheetLoad {
            if case (1...rows, 1...columns) = (indexPath.row, indexPath.column) {
                if indexPath.column - 1 < (viewModel.sheet?.values[indexPath.row - 1].count)! {
                    cell.setup(with: viewModel.sheet?.values[indexPath.row - 1][indexPath.column - 1] ?? "")
                } else {
                    cell.setup(with: "")
                }
            }
        }

        return cell
    }
}
class SpreadsheetViewCell: Cell {
    static let identifier = "sheetCell"
    let label = UILabel()
  
    public func setup(with text:String) {
        label.text = text
        label.textAlignment = .left
        label.textColor = .white
        backgroundColor = .black
        contentView.addSubview(label)
    }
    
    public func setupDefault(with text:String) {
        label.text = text
        label.textAlignment = .center
        label.textColor = .white
        backgroundColor  = #colorLiteral(red: 0.187317878, green: 0.1923363805, blue: 0.2093544602, alpha: 1)
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}
