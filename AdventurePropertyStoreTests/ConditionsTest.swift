//
//  ConditionsTest.swift
//  AdventurePropertyStoreTests
//
//  Created by Ingmar Drewing on 01.05.23.
//


import XCTest

final class ConditionsTest: XCTestCase {
    
    override func setUpWithError() throws {
        Game.clearAll()
    }

    override func tearDownWithError() throws {
        Game.clearAll()
    }
    
    func testCondition() throws {
        let legolas = GameEntity(name: "legolas", id: "npc01")
        legolas.createInitialProperty(valueType: .Dexterity, valueAmount: 18)
        legolas.addExperience(experienceTag: "attended Elrond's Council")
        legolas.updatePropertiesForReading()
        
        Game.gameImpl.setPlayerCharacter(gameEntity: legolas)

        let condition = Condition(.Dexterity, .equalTo, 18, targetFunction: {return Game.gameImpl.playerCharacter!})

        
        XCTAssertTrue(condition.evaluate())
    
        let conditionLess = Condition(.Dexterity, .lessThan, 19, targetFunction: {return Game.gameImpl.playerCharacter!})
        
        XCTAssertTrue(conditionLess.evaluate())

        let conditionGreater = Condition(.Dexterity, .greaterThan, 17, targetFunction: {return Game.gameImpl.playerCharacter!})

        XCTAssertTrue(conditionGreater.evaluate())
        
        let conditionExperienced = Condition(.Experience, .includes, 0, "attended Elrond's Council", targetFunction: {return Game.gameImpl.playerCharacter!})
        
        XCTAssertTrue(conditionExperienced.evaluate())

    }
    
    
}
