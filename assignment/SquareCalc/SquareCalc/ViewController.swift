//
//  ViewController.swift
//  SquareCalc
//
//  Created by 석민솔 on 2021/07/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var widthField: UITextField!
    @IBOutlet weak var areaField: UITextField!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func doCalc(_ sender: Any) {
        if let heightText = heightField.text, let height = Double(heightText), let widthText = widthField.text, let width = Double(widthText) {
            let area = height * width
            areaField.text = numberFormatter.string(from: NSNumber(value: area))
        }
        // 키보드 없애기
        view.endEditing(true)
    }
    
    // heightField, widthField에서 return 키 눌렀을 때
    @IBAction func textFieldFinishEdit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func touchViewEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
}

