//
//  ViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 24.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var bodyCondition: Condition?
    
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
    
    @IBOutlet weak var genderSelected: UISegmentedControl!
    
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var information: UILabel!
    
    @IBOutlet weak var weightValue: UITextField!
    
    @IBOutlet weak var heightValue: UITextField!
    
    @IBOutlet weak var BMI_Value: UILabel!
    
    @IBOutlet weak var moreInfoBtn: UIButton!
    
    @IBAction func CalculateBMI(_ sender: AnyObject) {
        
        if let _weight = Double(weightValue.text!){
            if let _height = Double(heightValue.text!){
                
                let calulationResult = calculation(weight: _weight, height: _height)
                
                BMI_Value.text = calulationResult
                
                if Double(calulationResult)! < 15 {
                    information.text = bodyConditions["very_underweight"]
                    bodyCondition = Condition.very_underweight
                    
                } else if Double(calulationResult)! > 15 && Double(calulationResult)! < 16{
                    information.text = bodyConditions["severely_underweight"]
                    bodyCondition = Condition.severely_underweight
                    
                } else if Double(calulationResult)! > 16 && Double(calulationResult)! < 18{
                    information.text = bodyConditions["underweight"]
                    bodyCondition = Condition.underweight
                    
                } else if Double(calulationResult)! > 18 && Double(calulationResult)! < 25{
                    information.text = bodyConditions["normal"]
                    bodyCondition = Condition.normal
                    
                } else if Double(calulationResult)! > 25 && Double(calulationResult)! < 30{
                    information.text = bodyConditions["overweight"]
                    bodyCondition = Condition.overweight
                    
                } else if Double(calulationResult)! > 30 {
                    information.text = bodyConditions["obese"]
                    bodyCondition = Condition.obese
                }
                
                moreInfoBtn.isEnabled = true
                
            }
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
//        let rounded = round(100 * sender.value) / 100
//        let final = rounded
        ageLabel.text = "\(Int(round(sender.value)))"
    }
    
    
    func calculation(weight: Double, height: Double) -> String{
        let result: Double = weight / (pow((height / 100), 2))
        return String(Int(round(result)))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        let newContion = bodyCondition
        
        var newGender: Gender
        
        let newBMI_Value = Double(BMI_Value.text!)
        
        if genderSelected.selectedSegmentIndex == 0{
            newGender = .Male
        } else{
            newGender = .Female
        }
        
        let newPerson = Person(_gender: newGender, _condition: newContion!, _BMI: newBMI_Value!, _age: Int(ageSlider.value))
        
        let navController = segue.destination as! UINavigationController
        if let detailedViewController = navController.topViewController as! DetailedViewController?{
            detailedViewController.person = newPerson
        }
        
        
    }
}

