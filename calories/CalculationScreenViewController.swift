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

class CalculationScreenViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var genderSelected: UISegmentedControl!
  @IBOutlet weak var ageSlider: UISlider!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var weightValue: UITextField!
  @IBOutlet weak var heightValue: UITextField!
  @IBOutlet weak var calcBtn: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var jsonToPass: JSON?
  
  @IBAction func sliderValueChanged(_ sender: UISlider) {
    ageLabel.text = "\(Int(round(sender.value)))"
    
    if heightValue.text != nil && weightValue.text != nil {
      calcBtn.isEnabled = true
    }
  }
  
  @IBAction func calculateButtonPressed(_ sender: UIButton) {
    
    guard let newHeight = Int(heightValue.text!) else{
      return
    }
    guard let newWeight = Int(weightValue.text!) else{
      return
    }
    
    let newAge = Int(ageSlider.value)
    var newGender: Gender
    if genderSelected.selectedSegmentIndex == 0{
      newGender = .Male
    } else {
      newGender = .Female
    }
    
    let person = Person(_gender: newGender,
                        _weight: newWeight,
                        _height: newHeight,
                        _age: newAge)
    
    performRequest(for: person)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.heightValue.delegate = self
    self.weightValue.delegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.activityIndicator.isHidden = true
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  
  func performRequest(for person: Person){
    let EndPoint: String = "https://bmi.p.mashape.com/"
    let _parameters: Parameters = [
      "weight": ["value": person.weight, "unit": "kg"],
      "height": ["value": person.height, "unit": "cm"],
      "sex": "\(person.gender.rawValue)",
      "age": person.age
    ]
    let _headers: HTTPHeaders = [
      "X-Mashape-Key": "FYXjzFgpJgmshPFR4cCXV2Do7FpOp13Kh8OjsnoQRIJkoLa6Hf",
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
    
    
    self.activityIndicator.isHidden = false
    self.activityIndicator.startAnimating()
    
    Alamofire.request(EndPoint,
                      method: .post,
                      parameters: _parameters,
                      encoding: JSONEncoding.default,
                      headers: _headers).responseJSON {
                        responseData in
                        
                        if responseData.result.value != nil{
                          self.jsonToPass = JSON(responseData.result.value!)
                        }
                        self.activityIndicator.isHidden = true
                        self.performSegue(withIdentifier: "toPersonalInfoView", sender: self)
                        
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    if segue.identifier == "toPersonalInfoView"{
      let vc = segue.destination as! DetailedViewController
      vc.jsonFromRequest = self.jsonToPass
    }
  }
}

