//
//  File.swift
//  calories
//
//  Created by Alexey Savchenko on 25.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import Foundation

enum Condition: String {
    case very_underweight = "very underweight"
    case severely_underweight = "severely underweight"
    case underweight = "underweight"
    case normal = "normal weight"
    case overweight = "overweight"
    case obese = "exessive weight"
}

enum Gender: String {
    case Male = "m"
    case Female = "f"
}

class Person {
    
    var gender: Gender
    var weight: Int
    var height: Int
    var age: Int
    
    init(_gender: Gender, _weight: Int, _height: Int, _age: Int) {
        self.gender = _gender
        self.weight = _weight
        self.height = _height
        self.age = _age
    }
}
