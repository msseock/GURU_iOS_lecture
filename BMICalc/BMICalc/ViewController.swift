//
//  ViewController.swift
//  BMICalc
//
//  Created by 석민솔 on 2021/06/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var BMIField: UITextField!
    
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal // NumberFormatter.Style.decimal과 같음!
        nf.minimumFractionDigits = 0
        nf.maximumSignificantDigits = 3
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func bmiCalculation(_ sender: Any) {
        if let heightText = heightField.text, let height = Double(heightText), let weightText = weightField.text, let weight = Double(weightText) {
            // bmi = 체중 / 키^2
            let bmi = weight / ((height/100) * (height/100))
            BMIField.text = numberFormatter.string(from: NSNumber(value: bmi))
        }
    }
    
    @IBAction func textFieldFinishEdit(_ sender: Any) {
        print("End!!")
    }
}

