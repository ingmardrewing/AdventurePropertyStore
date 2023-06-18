//
//  GameTest.swift
//  AdventurePropertyStoreTests
//
//  Created by Ingmar Drewing on 03.06.23.
//

import XCTest

class GameTest :XCTestCase {
    
    override func setUpWithError() throws {
        Game.clearAll()
    }

    override func tearDownWithError() throws {
        Game.clearAll()
    }
    
    func testScene() throws {
        /*
        let legolas = GameEntity(name: "Legolas", id: "legolas")
        let grumf = GameEntity(name: "Grumf", id: "npc01")
         */
    }
}
