//
//  RecipeViewController.swift
//  calories
//
//  Created by Alexey Savchenko on 23.11.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class RecipeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _recipe = selectedRecipe {
            
            recipeTitle.text = _recipe.label
            
            let imageURL = _recipe.image
            let imageData = try? Data(contentsOf: imageURL)
            recipeImage.image = UIImage(data: imageData!)
            
            for item in _recipe.ingredients{
                ingredients.text! += "\(item); \n"
            }
            for item in _recipe.healthLabels{
                healthLabels.text! += "\(item); "
            }
            
            sourceLabel.text = "Provided by: \(_recipe.source)"
        }
    }
    
    
    //MARK: PROPERITIES
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var healthLabels: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var recipeURLButton: UIButton!
    
    var url: URL{
        get{
            return URL(string: (selectedRecipe?.URL)!)!
        }
    }
    
    
    
    var selectedRecipe: Recipe?
    
    //MARK: METHODS
    
    @IBAction func gotoRecipeURL(_ sender: UIButton) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
}
