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
    
    init(_ valueType: ValueType, _ compareMode: CompareMode, _ comparedValue: Int? = 0, _ experienceTag: String? = ""){
        self.valueType = valueType
        self.compareMode = compareMode
        self.comparedValue = comparedValue!
        self.experienceTag = experienceTag!
    }

    func evaluate(gameEntity: GameEntity) -> Bool {
        switch compareMode {
        case .equalOrGreaterThan:
            return gameEntity.getPropertyValue(valueType: valueType) >= comparedValue
        case .equalOrLessThan:
            return gameEntity.getPropertyValue(valueType: valueType) <= comparedValue
        case .equalTo:
            return gameEntity.getPropertyValue(valueType: valueType) == comparedValue
        case .greaterThan:
            return gameEntity.getPropertyValue(valueType: valueType) > comparedValue
        case .lessThan:
            return gameEntity.getPropertyValue(valueType: valueType) < comparedValue
        case .includes:
            return gameEntity.hasExperience(experienceTag: experienceTag)
        }
    }
}
