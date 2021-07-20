//
//  ViewController.swift
//  UIControlBasic
//
//  Created by swuad_21 on 2021/07/16.
//

import UIKit

class ViewController: UIViewController {
    var previousIndex:Int = 0 // 이전 화면 인덱스
    var selectedIndex:Int = 0 // 띄워야 할 인덱스
    @IBOutlet var tabBtns: [UIImageView]!
    @IBOutlet weak var tabStackView: UIStackView!
    
    var viewControllers = [UIViewController]()
    
    static let firstViewController = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "firstView")
    
    static let secondViewController = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "secondView")
    
    static let thirdViewController = UIStoryboard(name: "Third", bundle: nil).instantiateViewController(withIdentifier: "thirdView")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        for btn in tabBtns {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
            btn.isUserInteractionEnabled = true // user가 동작을 가했을 때 인식할 수 있도록
            btn.addGestureRecognizer(tap) // 탭을 인식할 수 있는 상태가 됨
        }
        
        viewControllers.append(ViewController.firstViewController)
        viewControllers.append(ViewController.secondViewController)
        viewControllers.append(ViewController.thirdViewController)
        
        // 첫번째 뷰 골라서 집어넣기
        let currentVC = viewControllers[0]
        currentVC.view.frame = UIApplication.shared.windows[0].frame // 앱 전체를 감싸고 있는 최상단 정보에서 전체 앱의 화면 크기를 얻어옴
        currentVC.didMove(toParent: self) // 위치 이동(관계 설정)
        self.addChild(currentVC) // 관계설정2
        self.view.addSubview(currentVC.view) // 실제로 화면이 그려지도록 함
        self.view.bringSubviewToFront(tabStackView)
    }

    @objc func tabTapped(_ sender:UITapGestureRecognizer) {
        // 탭 버튼을 터치하면 화면전환
        NSLog("탭탭탭!")
        if let tag = sender.view?.tag {
            previousIndex = selectedIndex
            selectedIndex = tag
            
            // 이전화면 빼주기
            let previousVC = viewControllers[previousIndex]
            previousVC.willMove(toParent: self)
            previousVC.view.removeFromSuperview() // 뷰 빼기
            previousVC.removeFromParent() // 관계도에서 빼기
            
            // 현재 뷰 올려주기
            let currentVC = viewControllers[selectedIndex]
            currentVC.view.frame = UIApplication.shared.windows[0].frame
            currentVC.didMove(toParent: self)
            self.addChild(currentVC)
            self.view.addSubview(currentVC.view)
            
            // 탭 위에 올려주기
            self.view.bringSubviewToFront(tabStackView)
        }
    }


}

