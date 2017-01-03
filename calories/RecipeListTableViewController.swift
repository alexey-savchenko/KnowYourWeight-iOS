//
//  RecipeListTableViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 17.11.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation
import Alamofire
import AsyncDisplayKit

class RecipeListTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for item in (JSONData?["hits"].array)!{
      let unprocessedRecipe = item["recipe"]
      var ingrigientsForRecipe = [String]()
      
      let ingregients = unprocessedRecipe["ingredients"].array
      for item in ingregients!{
        ingrigientsForRecipe.append(item["text"].stringValue)
      }
      
      let localRecipe = Recipe(label: unprocessedRecipe["label"].string!,
                               source: unprocessedRecipe["source"].string!,
                               ingredients: ingrigientsForRecipe,
                               URL: unprocessedRecipe["url"].string!,
                               healthLabels: unprocessedRecipe["healthLabels"].arrayObject! as! [String],
                               image: URL(string: unprocessedRecipe["image"].string!)!
      )
      recipeArray.append(localRecipe)
    }
  }
  
  // MARK: PROPERTIES
  
  
  var JSONData: JSON?
  var recipeArray = [Recipe]()
  var selectedRecipeIndex: Int?
  var imgChache: NSMutableDictionary = NSMutableDictionary()
  var textChache: NSMutableDictionary = NSMutableDictionary()
  // MARK: - Table view data source
  
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipeArray.count
  }
  
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! recipeListCell
    
    // if image for IndexPath in chache load image from chache
//    if imgChache.allKeys.contains(where: {$0 as! Int == indexPath.row}){
//      DispatchQueue.main.async {
//        cell.recipeImage.image = self.imgChache.value(forKey: String(indexPath.row)) as! UIImage?
//        
//        if let labelTuple = self.textChache.value(forKey: String(indexPath.row)) as? (String?, String?){
//          cell.recipeLabel.text = labelTuple.0
//          cell.contentProviderLabel.text = labelTuple.1
//        }
//      }
//    }
    
    // if IndexPath key is not present in chache get UIImage from Data
    DispatchQueue.global().async {
      let imageData = try? Data(contentsOf: self.recipeArray[indexPath.row].image)
      DispatchQueue.main.async {
        if let imageFromData = UIImage(data: imageData!){
          cell.recipeImage.image = imageFromData
          cell.recipeLabel.text = self.recipeArray[indexPath.row].label
          cell.contentProviderLabel.text = self.recipeArray[indexPath.row].source
          // add image to chache
          self.imgChache.setObject(imageFromData, forKey: indexPath.row as NSCopying)
          
          let recipeLabel = cell.recipeLabel.text
          let contentProviderLabel = cell.contentProviderLabel.text
          self.textChache.setObject((recipeLabel, contentProviderLabel), forKey: indexPath.row as NSCopying)
          
        }
      }
    }
    
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let _cell = cell as? recipeListCell{
      DispatchQueue.global().async {
        let imageData = try? Data(contentsOf: self.recipeArray[indexPath.row].image)
        DispatchQueue.main.async {
          _cell.recipeImage.image = UIImage(data: imageData!)
          _cell.recipeLabel.text = self.recipeArray[indexPath.row].label
        }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    selectedRecipeIndex = indexPath.row
    performSegue(withIdentifier: "segueToRecipe", sender: UITableViewCell())
    print("\n \(indexPath.row) \n -------- \n \(selectedRecipeIndex) \n -------- \n \(recipeArray[selectedRecipeIndex!]) \n")
    
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "segueToRecipe"{
      if let controller = segue.destination as? RecipeViewController {
        print(controller)
        controller.selectedRecipe = recipeArray[selectedRecipeIndex!]
      }
    }
  }
}
