//
//  Game.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 28.05.23.
//

import Foundation

class Game {
    static let gameImpl :GameImpl = GameImpl()
    
    static func clearAll () {
        gameImpl.clearAll()
    }
    
    class GameImpl {
        var playerCharacter :GameEntity?
        var locations :[GameEntity] = []
        var options :[Option] = []
        var currentLocation :Int = 0
        var npcs :[GameEntity] = []
        var props :[GameEntity] = []
        
        init() {
            clearAll()
        }
        
        func clearAll () {
            self.playerCharacter = nil
            self.locations = []
            self.options = []
            self.currentLocation = 0
            self.npcs = []
            self.props = []
            PropertyStore.clearAll()
            DescriptionStore.clearAll()
            ExperienceStore.clearAll()
        }
                
        func addLocation (location :GameEntity) {
            if (locations.filter { $0 == location }.count != 0 ) {
                return
            }
            locations.append(location)
        }
        
        func addProp (prop :GameEntity){
            if (props.filter { $0 == prop }.count != 0 ) {
                return
            }
            props.append(prop)
        }
        
        func addNpc(npc: GameEntity) {
            if (npcs.filter { $0 == npc }.count != 0 ) {
                return
            }
            npcs.append(npc)
        }
        
        func setPlayerCharacter(gameEntity:GameEntity) {
            self.playerCharacter = gameEntity
        }
        
        func enterLocation() {
            getCurrentLocation().describe()
            let currentOptions = findCurrentOptions()
            for currentOption in currentOptions {
                currentOption.describe()
            }
        }
        
        private func getCurrentLocation () -> GameEntity {
            return locations[currentLocation]
        }

        func update() {
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
        
        func addOption (option :Option) {
            options.append(option)
        }
        
        func findCurrentOptions () -> [Option]{
            let loc = locations[currentLocation]
            let gameScene = getScene()
            
            return options.filter { $0.isRelevantFor(gameScene: gameScene) }
        }
        
        func getScene () -> GameScene {
            let currentLocation = getCurrentLocation()
            let currentNpcs = npcs.filter{$0.location == currentLocation}
            let currentProps = props.filter{$0.location == currentLocation}
            
            return GameScene(playerCharacter: playerCharacter!, location: getCurrentLocation(), npcs: currentNpcs, props: currentProps)
        }
    }
}



