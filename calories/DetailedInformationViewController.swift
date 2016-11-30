//
//  DetailedInformationViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 25.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var riskFactorLabel: UILabel!
    @IBOutlet weak var bodyConditionLabel: UILabel!
    @IBOutlet weak var idealWeightLabel: UILabel!
    
    
    
    var person: Person? = nil
    var dictionaryFromRequest: JSON? = nil
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        if person?.gender == Gender.Male{
            genderImage.image = UIImage(named: "male-sign")
        } else{
            genderImage.image = UIImage(named: "female-sign")
        }
        
        
        ageLabel.text = "Age: \(person!.age)"
        
        performRequest()
        
    }
    
    func performRequest(){
        let EndPoint: String = "https://bmi.p.mashape.com/"
        let _parameters: Parameters = [
            "weight": ["value": person!.weight, "unit": "kg"],
            "height": ["value": person!.height, "unit": "cm"],
            "sex": "\(person!.gender.rawValue)",
            "age": person!.age
        ]
        let _headers: HTTPHeaders = [
            "X-Mashape-Key": "FYXjzFgpJgmshPFR4cCXV2Do7FpOp13Kh8OjsnoQRIJkoLa6Hf",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        DispatchQueue.global().async {
            Alamofire.request(EndPoint, method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseJSON {responseData in
                if responseData.result.value != nil{
                    let swiftyJSONVar = JSON(responseData.result.value!)
                    
                    self.dictionaryFromRequest = swiftyJSONVar
                    
                    DispatchQueue.global().sync {
                        self.configureView(json: swiftyJSONVar)
                    }
                }
            }
        }
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
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
