//
//  Options.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 03.06.23.
//

import Foundation

enum EffectTypes :Equatable {
    case locationChange, enteringCombat, attack, flee, exitCombat, propertyChange, takeItem
}

class Effect {
    let targets :[GameEntity] = []
    
}

class Option {
    let requiredPresentEntities :[GameEntity]
    let description :Description
    let effect :Effect
    
    init(requiredPresentEntities: [GameEntity], description: Description, effect: Effect) {
        self.requiredPresentEntities = requiredPresentEntities
        self.description = description
        self.effect = effect
    }
    
    func isRelevantFor (gameScene :GameScene) -> Bool {
        
        let givenEntities = gameScene.getGivenEntities()
        var requirementCounter = 0
        for requiredEntity in requiredPresentEntities {
            if (givenEntities.contains(requiredEntity)){
                requirementCounter += 1
            }
        }
        
        return requirementCounter == requiredPresentEntities.count
    }
    
    func describe() {
        print (description)
    }
}

struct GameScene {
    var playerCharacter :GameEntity
    var location :GameEntity
    var npcs :[GameEntity]
    var props :[GameEntity]
    
    func getGivenEntities () -> [GameEntity] {
        return npcs + props + [playerCharacter] + [location]
    }
}
