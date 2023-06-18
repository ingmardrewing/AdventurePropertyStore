//
//  AdventurePropertyStoreTests.swift
//  AdventurePropertyStoreTests
//
//  Created by Ingmar Drewing on 29.04.23.
//

import XCTest

final class PropertyStoreTest: XCTestCase {
    
    override func setUpWithError() throws {
        Game.clearAll()
    }

    override func tearDownWithError() throws {
        Game.clearAll()
    }
    
    func testUnsetProperties() throws {
        let legolas = GameEntity(name: "Legolas", id: "npc01")
        XCTAssertEqual(legolas.getPropertyValue(valueType: .Dexterity), 0)
    }
    
    func testCreateProperties() throws {
        let legolas = GameEntity(name: "Legolas", id: "npc01")
        legolas.createInitialProperty(valueType: .Dexterity, valueAmount: 18)
        legolas.updatePropertiesForReading()
        XCTAssertEqual(legolas.getPropertyValue(valueType: .Dexterity), 18)
    }
    
    func testMultiplePropertyTargets() throws {
        
        let legolas = GameEntity(name: "Legolas", id: "npc01")
        legolas.createInitialProperty(valueType: .Dexterity, valueAmount: 18)
        legolas.updatePropertiesForReading()
        
        XCTAssertTrue(legolas.getPropertyValue(valueType: .Dexterity) == 18)
        
        let pippin = GameEntity(name: "Pippin", id: "npc02")
        pippin.createInitialProperty(valueType: .Dexterity, valueAmount: 18)
        pippin.updatePropertiesForReading()
        
        XCTAssertTrue(pippin.getPropertyValue(valueType: .Dexterity) == 18)
        
        PropertyStore.addProperty(valueType: .Dexterity, valueAmount: -1, durationType: .Limited, durationAmount: 1, targets: legolas,pippin)
        pippin.updatePropertiesForReading()
        legolas.updatePropertiesForReading()
        
        XCTAssertEqual(pippin.getPropertyValue(valueType: .Dexterity), 17)
        XCTAssertEqual(legolas.getPropertyValue(valueType: .Dexterity), 17)
    }
    
    func testCreateTransientProperty() throws {
        let pippin = GameEntity(name: "Pippin", id: "npc02")
        pippin.createInitialProperty(valueType: .Dexterity, valueAmount: 18)
        pippin.updatePropertiesForReading()
        
        XCTAssertEqual(pippin.getPropertyValue(valueType: .Dexterity), 18)
        
        PropertyStore.addProperty(valueType: .Dexterity, valueAmount: 1, durationType: .Limited, durationAmount: 1, targets: pippin)
                
        pippin.updatePropertiesForReading()
        XCTAssertEqual(pippin.getPropertyValue(valueType: .Dexterity), 19)
        
        PropertyStore.endTurn()
        pippin.updatePropertiesForReading()

        XCTAssertEqual(pippin.getPropertyValue(valueType: .Dexterity), 18)
    }
}
