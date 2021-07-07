//
//  IntroViewController.swift
//  BasicSequence
//
//  Created by 석민솔 on 2021/07/07.
//

import UIKit
import SwiftyGif

class IntroViewController:UIViewController {
    @IBOutlet weak var intro_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let gif = try UIImage(gifName: "alpacahola.gif")
            self.intro_image.setGifImage(gif, loopCount: 1) // will loop forever
            self.intro_image.delegate = self
        } catch {
            NSLog("재생불가")
        }
        // 로딩이 필요한 정보가 있다면 이때 로드를 완료,
        // 화면을 전환한다.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 몇초 후에 화면을 전환하겠다
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.goMainView()
        }
    }
}

extension IntroViewController:SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        NSLog("gifDidStop")
    }
    
    func goMainView() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView") {    // viewController 불러오기
                vc.modalPresentationStyle = .fullScreen // 모양은 fullscreen으로 설정
                self.present(vc, animated: true, completion: nil)   // 현재 뷰에서 띄우도록 함
        }
    }
}
