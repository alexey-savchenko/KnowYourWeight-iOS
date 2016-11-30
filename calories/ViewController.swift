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
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBOutlet weak var genderSelected: UISegmentedControl!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightValue: UITextField!
    @IBOutlet weak var heightValue: UITextField!
    @IBOutlet weak var calcBtn: UIButton!
    
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        ageLabel.text = "\(Int(round(sender.value)))"
        
        if heightValue.text != nil && weightValue.text != nil {
            calcBtn.isEnabled = true
        }
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
        
        let detailedViewController = segue.destination as! DetailedViewController
        
        detailedViewController.person = newPerson
    }
}

