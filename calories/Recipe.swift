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


struct Recipe{
    
    static let edamamAppId = "9a96cba7"
    static let edamamAppKey = "7cf59ee1bb0210e11163637e109c7f57"
    
    let label: String
    let source: String
    let ingredients: [String]
    let ingredientLines: [String]
    let image: URL
}
