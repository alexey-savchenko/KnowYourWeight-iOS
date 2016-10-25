//
//  DetailedInformationViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 25.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController, UINavigationControllerDelegate{

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
