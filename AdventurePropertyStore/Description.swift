//
//  Description.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 29.04.23.
//

import Foundation

class DescriptionStore {
    static var descriptions :[Description] = []
    
    static func add (description: Description) {
        descriptions.append(description)
    }
    
    static func visitedBy(descriptionCollector: DescriptionCollector){
        descriptions
            .filter{
                $0.target == descriptionCollector.target
            }
            .forEach {
                $0.visitedBy(descriptionCollector: descriptionCollector)
            }
    }
}

struct DescriptionContent {
    let text: String
    let image: String
    let imageText: String
    let vignette: String
}

class Description {
    let conditions: [Condition]
    let content: DescriptionContent
    let target: GameEntity
    
    init(conditions: [Condition],
         content: DescriptionContent,
         target: GameEntity) {
        self.conditions = conditions
        self.content = content
        self.target = target
    }

    func evaluate() -> Bool {
        for c in conditions {
            if !c.evaluate(gameEntity: target){
                return false
            }
        }
        return true
    }

    func visitedBy (descriptionCollector: DescriptionCollector) {
        if(evaluate()){
            descriptionCollector.addDescriptionContent(descriptionContent: content)
        }
    }
}
