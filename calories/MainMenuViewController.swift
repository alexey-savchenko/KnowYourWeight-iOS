//
//  MainMenuViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 07.11.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the 
  }
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
  
}
