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

class DetailedViewController: UIViewController{

    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    
    var person: Person? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        print("----------------------")
//        print(person!.age)
//        print(person!.weight)
//        print(person!.height)
//        print(person!.BMI)
//        print(person!.BMR)
//        print("----------------------")
        
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
        
        Alamofire.request(EndPoint, method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseJSON {response in
            //TODO: Handle response
            
                print("+++++++++++ \n")
            
                print("\n +++++++++++ \n")
            
        }

    }
    
    //let validParams = JSONSerialization.isValidJSONObject(parameters)
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
