//
//  ThirdViewController.swift
//  ScreenChangeExample
//
//  Created by 석민솔 on 2021/07/06.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var label_text = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("Third view Init")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.label.text = self.label_text
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.label.text = self.label_text
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        if let preVC = self.presentingViewController as? UIViewController {
            preVC.dismiss(animated: false, completion: nil)
        }
    }
}
