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
            
            
            
            let localRecipe = Recipe(label: unprocessedRecipe["label"].string!, source: unprocessedRecipe["source"].string!, ingredients: ingrigientsForRecipe, ingredientLines: unprocessedRecipe["ingredientLines"].arrayObject! as! [String], image: URL(string: unprocessedRecipe["image"].string!)!)
            
            print(localRecipe)
            recipeArray.append(localRecipe)
        }
    }
    
    // MARK: PROPERTIES
    
    var JSONData: JSON?
    var recipeArray = [Recipe]()
    
    
    
    
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeArray.count
    }
    
    //TODO: FIX
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeNmeCell", for: indexPath) as! recipeListCell
//        
//        let imageURL = recipeArray[indexPath.row].image
//        let imageData = try? Data(contentsOf: imageURL)
//        
//        cell.recipeImage = UIImageView(image: UIImage(data: imageData!))
//        cell.recipeLabel.text = recipeArray[indexPath.row].label
//        
//        
//        
//        return cell
//    }
//    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}