//
//  DailyWebtoonListViewController.swift
//  NaverWebtoonExample
//
//  Created by swuad_31 on 2021/07/14.
//

import UIKit
import Parchment

class DailyWebtoonListViewController:UIViewController {
    var pagingViewController:PagingViewController!
    var viewControllers:[ViewController] = []
    let dayTitles = ["월", "화", "수", "목", "금", "토", "일"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for title in dayTitles {
            if let vc = storyboard?.instantiateViewController(identifier: "webtoonListView") as? ViewController {
                vc.title = title
                viewControllers.append(vc)
            }
        }

        pagingViewController = PagingViewController(viewControllers: viewControllers)
        pagingViewController.menuItemSize = .sizeToFit(minWidth: 30, height: 40)
        pagingViewController.menuItemSpacing = 0
        pagingViewController.menuItemLabelSpacing = 0
        pagingViewController.selectedBackgroundColor = UIColor(red: 5/255, green: 222/255, blue: 103/255, alpha: 1)
        pagingViewController.selectedTextColor = .white
        pagingViewController.indicatorOptions = .hidden
    }
    
    // 뷰 로드 후에 레이아웃 subView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addChild(pagingViewController)
        pagingViewController.view.frame = self.view.frame
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }
    
}
