//
//  Recipe.swift
//  calories
//
//  Created by Alexey Savchenko on 10.11.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Ingridient {
    let text: String
    let quantity: Double
    let measure: String
    let food: String
    let weight: Double
}

enum Diet: String{
    case balanced = "balanced"
    case high_protein = "high-protein"
    case high_fiber = "high-fiber"
    case low_carb = "low-carb"
    case low_sodium = "low-sodium"
    
    static let dietArray = ["Balanced", "High-protein", "Low-carbonate", "Low-fat"]
}

struct Recipe{
    
    static let edamamAppId = "9a96cba7"
    static let edamamAppKey = "7cf59ee1bb0210e11163637e109c7f57"
    
    let label: String
    let source: String
    let ingredients: [Ingridient]
    let ingredientLines: String ///test
    
    
    
}
