//
//  File.swift
//  calories
//
//  Created by Alexey Savchenko on 25.10.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

enum Condition {
    case very_underweight
    case severely_underweight
    case underweight
    case normal
    case overweight
    case obese
}

enum Gender {
    case Male
    case Female
}

class Person {
    var condition: Condition
    var gender: Gender
    var BMI: Double
    var age: Int
    
    init(_gender: Gender, _condition: Condition, _BMI: Double, _age: Int) {
        self.gender = _gender
        self.condition = _condition
        self.BMI = _BMI
        self.age = _age
    }
    
    func showProps()-> [String]{
        return Mirror(reflecting: self).children.flatMap {$0.label}
    }
}
