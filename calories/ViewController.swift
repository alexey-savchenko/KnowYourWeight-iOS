//
//  ViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 24.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.heightValue.delegate = self
        self.weightValue.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    let bodyConditions: Dictionary = ["very_underweight": "You are very severely underweight",
                                      "severely_underweight": "You are severely underweight",
                                      "underweight": "You are underweight",
                                      "normal": "You have normal weight",
                                      "overweight": "You are overweight",
                                      "obese": "You are obese"]
    
    @IBOutlet weak var information: UILabel!
    
    @IBOutlet weak var weightValue: UITextField!
    
    @IBOutlet weak var heightValue: UITextField!
    
    @IBOutlet weak var BMI_Value: UILabel!
    
    @IBOutlet weak var moreInfoBtn: UIButton!
    
    @IBAction func CalculateBMI(_ sender: AnyObject) {
        
        let _weight = Double(weightValue.text!)
        
        let _height = Double(heightValue.text!)
        
        let calulationResult = calculation(weight: _weight!, height: _height!)
        
        BMI_Value.text = calulationResult
        
        if Double(calulationResult)! < 15 {
            information.text = bodyConditions["very_underweight"]
        } else if Double(calulationResult)! > 15 && Double(calulationResult)! < 16{
            information.text = bodyConditions["severely_underweight"]
        } else if Double(calulationResult)! > 16 && Double(calulationResult)! < 18{
            information.text = bodyConditions["underweight"]
        } else if Double(calulationResult)! > 18 && Double(calulationResult)! < 25{
            information.text = bodyConditions["normal"]
        } else if Double(calulationResult)! > 25 && Double(calulationResult)! < 30{
            information.text = bodyConditions["overweight"]
        } else if Double(calulationResult)! > 30 {
            information.text = bodyConditions["obese"]
        }
        moreInfoBtn.isEnabled = true
    }
    
    func calculation(weight: Double, height: Double) -> String{
        let result: Double = weight / (pow((height / 100), 2))
        return String(round(100 * result) / 100)
    }
}

