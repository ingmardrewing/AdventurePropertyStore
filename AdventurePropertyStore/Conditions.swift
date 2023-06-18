//
//  Conditions.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 01.05.23.
//

import Foundation

enum CompareMode :Equatable {
    case equalOrGreaterThan, equalOrLessThan, equalTo, greaterThan, lessThan, includes
}

struct Condition {
    let valueType: ValueType
    let compareMode: CompareMode
    let comparedValue : Int
    let experienceTag : String
    let targetFunction : () -> GameEntity
    
    init(_ valueType: ValueType, _ compareMode: CompareMode, _ comparedValue: Int? = 0, _ experienceTag: String? = "", targetFunction :@escaping () -> GameEntity){
        self.valueType = valueType
        self.compareMode = compareMode
        self.comparedValue = comparedValue!
        self.experienceTag = experienceTag!
        self.targetFunction = targetFunction
    }

    func evaluate() -> Bool {
        let target = targetFunction()
        print("xxx Evaluating for \(target.id):\nvalueType:\(valueType)\ncompareMode:\(compareMode)\ncompareValue:\(comparedValue)")
        
        switch compareMode {
        case .equalOrGreaterThan:
            return target.getPropertyValue(valueType: valueType) >= comparedValue
        case .equalOrLessThan:
            return target.getPropertyValue(valueType: valueType) <= comparedValue
        case .equalTo:
            return target.getPropertyValue(valueType: valueType) == comparedValue
        case .greaterThan:
            return target.getPropertyValue(valueType: valueType) > comparedValue
        case .lessThan:
            return target.getPropertyValue(valueType: valueType) < comparedValue
        case .includes:
            return target.hasExperience(experienceTag: experienceTag)
        }
    }
}

