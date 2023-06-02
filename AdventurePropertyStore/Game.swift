//
//  Game.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 28.05.23.
//

import Foundation

class Game {
    static let gameImpl :GameImpl = GameImpl()
    
    class GameImpl {
        var playerCharacter :GameEntity?
        var locations :[GameEntity] = []
        var npcs :[GameEntity] = []
        var props :[GameEntity] = []
        
        init () {}
        
        func startNewGame () {
            self.playerCharacter = GameEntity(name: "legolas", id: "legolas01")
        }
        
        func addLocation (gameEntity :GameEntity) {
            self.locations.append(gameEntity)
        }
        
        func setPlayerCharacter(gameEntity:GameEntity) {
            self.playerCharacter = gameEntity
        }
        
        func addNPC(gameEntity: GameEntity) {
            self.npcs.append(gameEntity)
        }

        func turn() {
            updateGameEntities(gameEntities: [playerCharacter!])
            updateGameEntities(gameEntities: npcs)
            updateGameEntities(gameEntities: locations)
            updateGameEntities(gameEntities: props)
        }
        
        private func updateGameEntities (gameEntities :[GameEntity]) {
            for gameEntity in gameEntities {
                gameEntity.updatePropertiesForReading()
                gameEntity.updateDescriptions()
            }
        }
    }
}

