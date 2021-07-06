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
            self.intro_image.setGifImage(gif, loopCount: -1)
        } catch {
            NSLog("재생불가")
        }
    }
}
