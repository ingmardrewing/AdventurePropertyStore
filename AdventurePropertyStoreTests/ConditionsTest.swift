//
//  ConditionsTest.swift
//  AdventurePropertyStoreTests
//
//  Created by Ingmar Drewing on 01.05.23.
//


import XCTest

final class ConditionsTest: XCTestCase {
    
    func testCondition() throws {
        let legolas = GameEntity(name: "legolas", id: "npc01")
        legolas.createInitialProperty(valueType: .Dexterity, valueAmount: 18)
        legolas.addExperience(experienceTag: "attended Elrond's Council")
        let condition = Condition(.Dexterity, .equalTo, 18)
        legolas.updatePropertiesForReading()
        
        XCTAssertTrue(condition.evaluate(gameEntity: legolas))
    
        let conditionLess = Condition(.Dexterity, .lessThan, 19)
        
        XCTAssertTrue(conditionLess.evaluate(gameEntity: legolas))

        let conditionGreater = Condition(.Dexterity, .greaterThan, 17)

        XCTAssertTrue(conditionGreater.evaluate(gameEntity: legolas))
        
        let conditionExperienced = Condition(.Experience, .includes, 0, "attended Elrond's Council")
        
        XCTAssertTrue(conditionExperienced.evaluate(gameEntity: legolas))

    }
    
    
}
