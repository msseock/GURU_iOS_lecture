//
//  ViewController.swift
//  LottoDraw
//
//  Created by 석민솔 on 2021/07/01.
//

import UIKit
import FMDB

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func doLoad(_ sender: Any) {
        print("DoLoad")
    }
    
    @IBAction func doDraw(_ sender: Any) {
        print("doDraw")
    }
    
    @IBAction func doSave(_ sender: Any) {
        print("doSave")
    }
}

