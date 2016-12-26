//
//  SavedRecipeTableViewController.swift
//  KnowYourWeight
//
//  Created by Alexey Savchenko on 13.12.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class SavedRecipeListTableViewController: UITableViewController {
    
    //MARK: PROPERITIES
    
    var recipes: [SavedRecipe] = []
    var selectedRecipe: SavedRecipe?
    
    //MARK: METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSavedRecipes()
        tableView.reloadData()
        
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedRecipeCell", for: indexPath) as! recipeListCell
        
        cell.recipeLabel.text = recipes[indexPath.row].title
        cell.recipeImage.image = UIImage(data: (recipes[indexPath.row].image as? Data)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRecipe = recipes[indexPath.row]
        
        performSegue(withIdentifier: "toSavedRecipe", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSavedRecipe"{
            //Adjust segue
            let target = segue.destination as! SavedRecipeViewController
            target.recipe = selectedRecipe!
            
        }
    }
    
    func getSavedRecipes(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try recipes = context.fetch(SavedRecipe.fetchRequest())
        } catch  {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let recipeToRemove = recipes[indexPath.row]
        
        managedContext.delete(recipeToRemove)
        
        if editingStyle == .delete
        {
            do {
                try managedContext.save()
                recipes.remove(at: indexPath.row)
                tableView.reloadData()
                
            } catch  {
                print(error)
            }
        }
    }
    
    @IBAction func deleteAllRecordsFromCoreData(_ sender: UIButton) {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedRecipe")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            print("\n All records are deleted! \n")
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    
    
    
}
