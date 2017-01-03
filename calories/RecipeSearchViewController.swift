//
//  FoodListController.swift
//  calories
//
//  Created by Alexey Savchenko on 08.11.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//
import Foundation
import Alamofire
import UIKit
import SwiftyJSON
import CoreText

class RecipeSearchViewController: UIViewController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.activityIndicator.isHidden = true
    dietButtonViewArray.append(balancedDietButtonView)
    dietButtonViewArray.append(highProteinDietButtonView)
    dietButtonViewArray.append(lowFatDietButtonView)
    
  }
  
  //MARK: PROPERTIES
  
  @IBOutlet weak var maximumCaloriesPerRecipeLabel: UILabel!
  @IBOutlet weak var searchBtn: UIButton!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var healthSegmentedControl: UISegmentedControl!
  
  @IBOutlet weak var balancedDietButtonView: dietButtonView!
  @IBOutlet weak var highProteinDietButtonView: dietButtonView!
  @IBOutlet weak var lowFatDietButtonView: dietButtonView!
  
  
  var selectedDiet: String? = nil
  var _responseInJSON: JSON?
  var dietButtonViewArray = [dietButtonView]()
  
  var selectedHealthOption: String{
    get{
      switch healthSegmentedControl.selectedSegmentIndex {
      case 0:
        return "alcohol-free"
      case 1:
        return "vegan"
      case 2 :
        return "vegetarian"
      default:
        return "alcohol-free"
      }
    }
  }
  
  
  //MARK: METHODS
  
  
  @IBAction func sliderChanged(_ sender: UISlider) {
    maximumCaloriesPerRecipeLabel.text = "\(Int(round(sender.value)))"
    
  }
  
  
  @IBAction func backButton(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func dietButtonPressed(_ sender: UIButton) {
    
    guard let _superView = sender.superview as? dietButtonView else { return }
    _superView.isSelected = true
    _superView.timesClicked += 1
    
    for item in dietButtonViewArray{
      if item.isSelected == false{
        item.enableDarkOverlay()
      }
    }
    if _superView.timesClicked % 2 == 0{
      for item in dietButtonViewArray{
        item.disableDarkOverlay()
      }
    }
    
    self.selectedDiet = sender.titleLabel?.text!.lowercased()
    
    searchBtn.isEnabled = true
    _superView.isSelected = false
    
    print("Selected diet \(self.selectedDiet)")
    
  }
  
  
  @IBAction func searchBtnPressed(_ sender: UIButton) {
    
    let endPoint = makeEndPoint()
    
    print(endPoint)
    
    self.activityIndicator.isHidden = false
    self.activityIndicator.startAnimating()
    Alamofire.request(endPoint).responseJSON{ response in
      
      if let value = response.result.value {
        self._responseInJSON = JSON(value)
        
        print("\n++++++\n\(self._responseInJSON!.endIndex)\n++++++\n")
        self.performSegue(withIdentifier: "goToRecipeList", sender: self)
      }
      self.activityIndicator.isHidden = true
    }
  }
  
  func makeEndPoint() -> String{
    return "https://api.edamam.com/search?q=&app_id=\(Recipe.edamamAppId)&app_key=\(Recipe.edamamAppKey)&from=0&to=75&diet=\(selectedDiet!)&calories=lte%20\(maximumCaloriesPerRecipeLabel.text!)&health=\(self.selectedHealthOption)"
  }
  @IBAction func goToSavedRecipesList(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "toSavedRecipes", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToRecipeList"{
      let controller = segue.destination as! RecipeListTableViewController
      controller.JSONData = _responseInJSON
    }
  }
}
