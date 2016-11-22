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
    @IBOutlet weak var progressBar: UIProgressView!
    
    let dietArray = ["Balanced", "High-protein", "Low-carbonate", "Low-fat"]
    var endPoint = ""
    var selectedDiet: String? = nil
    var _responseInJSON: JSON?
    var timer = Timer()
    
    @IBAction func selectDietBtnPressed(_ sender: UIButton) {
        dietPicker.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dietArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dietArray[row]
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
        
        let dietSelected = dietArray[row]
        
        selectDietBtn.setTitle(dietSelected, for: .normal)
        dietPicker.isHidden = true
        searchBtn.isEnabled = false
        
        selectedDiet = dietSelected.lowercased()
        
        endPoint = makeEndPoint()
        
        self.makeRequest(to: self.endPoint)
        
        progressBar.isHidden = false
        progressBar.progress = 0
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        
    }
    func timerAction(){
        progressBar.progress += 0.2
        if progressBar.progress == 1{
            timer.invalidate()
            progressBar.isHidden = true
            searchBtn.isEnabled = true
        }
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        
        print("================\n \(endPoint) \n ================\n ")
        
        
        
    }
    
    func makeEndPoint() -> String{
        return "https://api.edamam.com/search?q=&app_id=\(Recipe.edamamAppId)&app_key=\(Recipe.edamamAppKey)&from=0&to=1&diet=\(selectedDiet!)&calories=lte%20\(maximumCaloriesPerRecipeLabel.text!)&health=alcohol-free"
    }
    
    func makeRequest(to endPoint: String) {
        
        Alamofire.request(endPoint).responseJSON{ response in
            if let value = response.result.value {
                
                let responseInJSON = JSON(value)
                
                self._responseInJSON = responseInJSON
                print("\n++++++++++++++++++++++++++=+\n\(self._responseInJSON!)\n++++++++++++++++++++++++++=+\n")
                
                
                
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! RecipeListTableViewController
        controller.JSONData = _responseInJSON
    }
}
