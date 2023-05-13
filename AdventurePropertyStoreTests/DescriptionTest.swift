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
            conditions: [Condition(.Dexterity,.equalTo,19)],
            content: DescriptionContent(
                text: "Test text",
                image: "img01",
                imageText: "image text",
                vignette: "img02"),
            target: legolas)
        XCTAssertFalse(description.evaluate())
        
        DescriptionStore.add(description: description)
        XCTAssertEqual(DescriptionStore.descriptions.count, 1)
        
        var firstDescriptionContent = legolas.getDescriptionContents().first
        XCTAssertNil(firstDescriptionContent)
        
        PropertyStore.addProperty(valueType: .Dexterity, valueAmount: 1, durationType: .Limited, durationAmount: 1, targets: legolas)
        
        firstDescriptionContent = legolas.getDescriptionContents().first
        XCTAssertNotNil(firstDescriptionContent)
    }
    
    
}
