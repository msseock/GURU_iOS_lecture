//
//  TabCell.swift
//  GoogleAPI
//
//  Created by 석민솔 on 2021/08/02.
//  Copyright © 2021 BytePace. All rights reserved.
//

import UIKit

class TabCell:UICollectionViewCell {
    @IBOutlet weak var sheetTabName: UILabel!
    
}


// 걍 지금은 메모장으로 써야지 하하(실성)
public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print("cellForItemAt 호출\(indexPath.row)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath) as! TabCell
    let tablabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
    
    if let tabTitle = viewModel.propertySheets?[indexPath.row].properties?.title {
        tablabel.text = tabTitle
        cell.addSubview(tablabel)
        print("셀 라벨로 섭뷰 추가 완\(indexPath.row)")
        // 호출될 때마다 이미 있는데 호출이 다시됨
    } else {
        print("탭 이름 넣기 안됨")
//            tablabel.text = "\(indexPath.row)"
    }
    tablabel.textAlignment = .center
    

    cell.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.5960784314, blue: 0, alpha: 1)
    cell.layer.cornerRadius = 10
    return cell
}
