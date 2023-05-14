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
        legolas.createInitialProperty(valueType: .Health, valueAmount: 20)

        let description = Description(
            conditions: [Condition(.Dexterity,.equalTo,19)],
            content: DescriptionContent(
                text: "Test text",
                image: "img01",
                imageText: "image text",
                vignette: "img02"),
            target: legolas)
        let description2 = Description(
            conditions: [
                Condition(.Experience,.includes,0, "is battle worn"),
                Condition(.Health,.lessThan,8)
            ],
            content: DescriptionContent(
                text: "Legolas returns from the battle against the orcs",
                image: "img02",
                imageText: "image text2",
                vignette: "img02"),
            target: legolas)
        XCTAssertFalse(description.evaluate())
        
        DescriptionStore.add(description: description)
        DescriptionStore.add(description: description2)

        XCTAssertEqual(DescriptionStore.descriptions.count, 2)
        
        var firstDescriptionContent = legolas.getDescriptionContents().first
        XCTAssertNil(firstDescriptionContent)
        
        PropertyStore.addProperty(valueType: .Dexterity, valueAmount: 1, durationType: .Limited, durationAmount: 1, targets: legolas)
        
        firstDescriptionContent = legolas.getDescriptionContents().first
        XCTAssertNotNil(firstDescriptionContent)
        
        legolas.addExperience(experienceTag: "is battle worn")
        
        XCTAssertEqual(legolas.getDescriptionContents().count, 1)
        
        PropertyStore.addProperty(valueType: .Health, valueAmount: -16, durationType: .Limited, durationAmount: 1, targets: legolas)
        XCTAssertEqual(DescriptionStore.descriptions.count, 2)

    }
    
    
}
