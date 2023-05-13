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
        let condition = Condition(.Dexterity, .equalTo, 18)
        
        XCTAssertTrue(condition.evaluate(gameEntity: legolas))
    
        let conditionLess = Condition(.Dexterity, .lessThan, 19)
        
        XCTAssertTrue(conditionLess.evaluate(gameEntity: legolas))

        let conditionGreater = Condition(.Dexterity, .greaterThan, 17)

        XCTAssertTrue(conditionGreater.evaluate(gameEntity: legolas))
    }
    
    
}
