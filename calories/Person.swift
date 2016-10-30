//
//  File.swift
//  calories
//
//  Created by Alexey Savchenko on 25.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import Foundation

enum Condition {
    case very_underweight
    case severely_underweight
    case underweight
    case normal
    case overweight
    case obese
}

enum Gender: String {
    case Male = "m"
    case Female = "f"
}

class Person {
    var condition: Condition
    var gender: Gender
    var weight: Int
    var height: Int
    var age: Int
    
    init(_gender: Gender, _condition: Condition, _weight: Int, _height: Int, _age: Int) {
        self.gender = _gender
        self.condition = _condition
        self.weight = _weight
        self.height = _height
        self.age = _age
    }
}
