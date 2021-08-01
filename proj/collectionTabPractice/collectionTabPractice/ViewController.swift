//
//  ViewController.swift
//  collectionTabPractice
//
//  Created by 석민솔 on 2021/08/01.
//

import UIKit

class ViewController: UIViewController {
    var myCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: tabBar controller
        let view = UIView()
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // The margins used to lay out content in a section.
        layout.itemSize = CGSize(width: 40, height: 20)
        layout.scrollDirection = .horizontal
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "tabCell") // tabCell로 콜렉션뷰 셀 구성
        myCollectionView?.backgroundColor = #colorLiteral(red: 0.187317878, green: 0.1923363805, blue: 0.2093544602, alpha: 1)
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
        
    }
}

extension ViewController: UICollectionViewDataSource {
    // 콜렉션뷰에서 띄울 셀 개수. 나중에 설정할 때 viewModel에서 받아오는 sheet.count로 설정하면 될 것 같다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    // create return a new cell
    // You can customize each cell and add other UI elements to it as subviews.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.5960784314, blue: 0, alpha: 1)
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select collection view cell item")
    }
}

