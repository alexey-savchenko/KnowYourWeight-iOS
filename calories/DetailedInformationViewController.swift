//
//  DetailedInformationViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 25.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class DetailedViewController: UIViewController {
  
  @IBOutlet weak var BMILabel: UILabel!
  @IBOutlet weak var riskFactorLabel: UILabel!
  @IBOutlet weak var bodyConditionLabel: UILabel!
  @IBOutlet weak var idealWeightLabel: UILabel!
  
  
  var jsonFromRequest: JSON? = nil
  

  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    print(jsonFromRequest.debugDescription)
    self.configureView(json: jsonFromRequest!)
  }
  
  
  
  func configureView(json: JSON) {
    if let bmi = json["bmi"]["value"].string{
      self.BMILabel.text = "Body mass index (BMI) is \(bmi)"
    }
    if let risk = json["bmi"]["risk"].string{
      self.riskFactorLabel.text = risk
    }
    if let condition = json["bmi"]["status"].string{
      self.bodyConditionLabel.text = "Body condition - \(condition)"
    }
    if let idealWeight = json["ideal_weight"].string{
      self.idealWeightLabel.text = "Based on your parameters, your ideal weight is: \(idealWeight)"
    }
  }
}
