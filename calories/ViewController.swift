//
//  ViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 24.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightValue.delegate = self
        self.weightValue.delegate = self
        
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
    
    @IBOutlet weak var moreInfoBtn: UIButton!
    
    @IBAction func CalculateBMI(_ sender: AnyObject) {
        
        if let _weight = Double(weightValue.text!){
            if let _height = Double(heightValue.text!){
                
                let calulationResult = calculation(weight: _weight, height: _height)
                
                if calulationResult < 15 {
                  
                    information.text = bodyConditions["very_underweight"]
                    
                    
                } else if calulationResult > 15 && calulationResult < 16{

                    information.text = bodyConditions["severely_underweight"]
                    
                    
                } else if calulationResult > 16 && calulationResult < 18{

                    information.text = bodyConditions["underweight"]
                    
                    
                } else if calulationResult > 18 && calulationResult < 25{

                    information.text = bodyConditions["normal"]
                    
                    
                } else if calulationResult > 25 && calulationResult < 30{
                   
                    information.text = bodyConditions["overweight"]
                    
                    
                } else if calulationResult > 30 {
                 
                    information.text = bodyConditions["obese"]
                    
                }
                
                moreInfoBtn.isEnabled = true
                
            }
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        ageLabel.text = "\(Int(round(sender.value)))"
    }
    
    
    func calculation(weight: Double, height: Double) -> Int{
        let result: Double = weight / (pow((height / 100), 2))
        print("frst BMI: \(result)")
        return Int(round(result))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        let newHeight = Int(heightValue.text!)!
        
        let newWeight = Int(weightValue.text!)!
        
        let newAge = Int(ageSlider.value)
        
        var newGender: Gender
        
        if genderSelected.selectedSegmentIndex == 0{
            newGender = .Male
        } else {
            newGender = .Female
        }
        
        let newPerson = Person(_gender: newGender, _weight: newWeight, _height: newHeight, _age: newAge)
        
        let navController = segue.destination as! UINavigationController
        
        if let detailedViewController = navController.topViewController as? DetailedViewController {
            
            detailedViewController.person = newPerson
        
        }
    }
}

