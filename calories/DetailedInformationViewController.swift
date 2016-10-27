//
//  DetailedInformationViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 25.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController{
    
    
    @IBOutlet weak var genderImage: UIImageView!
    
    var person: Person? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("----------------------")
        print(person?.showProps())
        print("----------------------")
        
        if person?.gender == Gender.Male{
            genderImage.image = UIImage(named: "male-sign")
        } else{
            genderImage.image = UIImage(named: "female-sign")
        }
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
