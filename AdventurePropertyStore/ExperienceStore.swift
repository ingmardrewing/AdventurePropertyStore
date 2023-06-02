//
//  ExperienceStory.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 13.05.23.
//

import Foundation

class ExperienceStore {
    static var experiences : [Experience] = []
    
    static func addExperience(gameEntity:GameEntity, experience :String) {
        if (gameEntity.hasExperience(experienceTag: experience)){
            return
        }
        experiences.append(Experience(gameEntity: gameEntity, experience: experience))
    }
    
    static func experienced(gameEntity:GameEntity, experience:String) -> Bool{
        let foundExperiences = experiences.filter {
            $0.gameEntity == gameEntity && $0.experience == experience
        }
        return foundExperiences.count > 0
    }
}

struct Experience {
    let gameEntity :GameEntity
    let experience :String
}
