//
//  SavedRecipeViewController.swift
//  KnowYourWeight
//
//  Created by Alexey Savchenko on 26.12.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit

class SavedRecipeViewController: UIViewController {
  
  //MARK: Properities
  var recipe: SavedRecipe?
  
  var url: URL{
    get{
      return URL(string: (recipe?.url)!)!
    }
  }
  
  //MARK: Outlets
  @IBOutlet weak var recipeImage: UIImageView!
  @IBOutlet weak var recipeTitle: UILabel!
  @IBOutlet weak var ingredients: UILabel!
  
  
  
  
  //MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    recipeImage.image = UIImage(data: (recipe?.image)! as Data)
    recipeTitle.text = recipe?.title!
    ingredients.text = recipe?.ingredients!
    
  }
  
  @IBAction func openSourceURL(_ sender: UIButton) {
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
