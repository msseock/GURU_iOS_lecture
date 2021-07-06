//
//  SecondViewController.swift
//  NavigationBarBasic
//
//  Created by 석민솔 on 2021/07/07.
//

import UIKit

class SecondViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Test2"
    }
}
