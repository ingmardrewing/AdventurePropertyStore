//
//  AdventurePropertyStoreTests.swift
//  AdventurePropertyStoreTests
//
//  Created by Ingmar Drewing on 29.04.23.
//

import XCTest

final class ExperienceStoreTest: XCTestCase {
    
    override func setUpWithError() throws {
        Game.clearAll()
    }

    override func tearDownWithError() throws {
        Game.clearAll()
    }
    
    func testNoExperience() throws {
        let legolas = GameEntity(name: "Legolas", id: "npc01")
                
        XCTAssertFalse(legolas.hasExperience(experienceTag: "the void"))
    }
    
    
    func testAddExperience() throws {
        let legolas = GameEntity(name: "Legolas", id: "npc01")
        let experienceItem = "visited room 201"
        
        XCTAssertEqual(ExperienceStore.experiences.count, 0)
        
        legolas.addExperience(experienceTag: experienceItem)
        
        XCTAssertTrue(legolas.hasExperience(experienceTag: experienceItem))
        XCTAssertEqual(ExperienceStore.experiences.count, 1)
        
        legolas.addExperience(experienceTag: experienceItem)
        XCTAssertEqual(ExperienceStore.experiences.count, 1)

        
    }
}
