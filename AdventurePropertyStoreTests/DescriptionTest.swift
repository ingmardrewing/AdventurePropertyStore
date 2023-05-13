//
//  DescriptionText.swift
//  AdventurePropertyStoreTests
//
//  Created by Ingmar Drewing on 01.05.23.
//

import XCTest

final class DescripitionTest: XCTestCase {
    
    func testDescription() throws {
        let legolas = GameEntity(name: "legolas", id: "npc01")
        legolas.createInitialProperty(valueType: .Dexterity, valueAmount: 18)
        let description = Description(
            conditions: [Condition(.Dexterity,.equalTo,18)],
            content: DescriptionContent(
                text: "Test",
                image: "img01",
                imageText: "image text",
                vignette: "img02"),
            target: legolas)
        XCTAssertTrue(description.evaluate())
        
        DescriptionStore.add(description: description)
        XCTAssertEqual(DescriptionStore.descriptions.count, 1)
        
        let dc = legolas.getDescriptionContents().first
        XCTAssertEqual(dc?.text, "trt")
    }
    
    
}
