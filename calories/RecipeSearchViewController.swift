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


class RecipeSearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dietPicker.dataSource = self
        self.dietPicker.delegate = self
        
    }
    
    @IBOutlet weak var maximumCaloriesPerRecipeLabel: UILabel!
    @IBOutlet weak var dietPicker: UIPickerView!
    @IBOutlet weak var selectDietBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
 
    
    var endPoint = ""
    var selectedDiet: String? = nil
    var _responseInJSON: JSON?
    
    @IBAction func selectDietBtnPressed(_ sender: UIButton) {
        dietPicker.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Diet.dietArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Diet.dietArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        maximumCaloriesPerRecipeLabel.text = "\(Int(round(sender.value)))"
    }
    
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let dietSelected = Diet.dietArray[row]
        
        selectDietBtn.setTitle(dietSelected, for: .normal)
        dietPicker.isHidden = true
        searchBtn.isEnabled = true
       
        selectedDiet = dietSelected.lowercased()
    }
    
    func constructRequestEndpoint() -> String {
        return "https://api.edamam.com/search?q=&app_id=\(Recipe.edamamAppId)&app_key=\(Recipe.edamamAppKey)&from=0&to=20&diet=\(selectedDiet!)&calories=lte%20\(maximumCaloriesPerRecipeLabel.text!)&health=alcohol-free"
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        endPoint = constructRequestEndpoint()
        print("================\n \(endPoint) ================\n ")
        
        DispatchQueue.global().async {
            self.makeRequest(to: self.endPoint)
        }
    }
    
    func makeRequest(to endPoint: String) {
        Alamofire.request(endPoint).responseJSON{ response in
            if response.result.value != nil{
                let responseInJSON = JSON(response.result.value!)
                
                print(responseInJSON)
                self._responseInJSON = responseInJSON
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! RecipeListTableViewController
        controller.JSONData = _responseInJSON
    }
}
