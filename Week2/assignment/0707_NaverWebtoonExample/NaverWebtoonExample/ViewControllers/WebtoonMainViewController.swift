//
//  WebtoonMainViewController.swift
//  NaverWebtoonExample
//
//  Created by swuad_31 on 2021/07/14.
//

import UIKit

class WebtoonMainViewController:UIViewController {
    @IBOutlet weak var bannerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerViewController = BannerViewController()
        // 화면에 표시되도록 넣어주기
        bannerScrollView.addSubview(bannerViewController.view)
        // 스크롤이 가능하도록 컨텐츠 사이즈 설정
        bannerScrollView.contentSize = bannerViewController.view.frame.size
    }
}
