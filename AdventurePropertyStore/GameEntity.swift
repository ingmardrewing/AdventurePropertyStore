//
//  File.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 29.04.23.
//

import Foundation

class GameEntity :Equatable {
    
    let name : String
    let id : String
    var properties :[Property] = []
    var descriptions :[DescriptionContent] = []
    var location :GameEntity?
    
    static func == (lhs: GameEntity, rhs: GameEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    func updatePropertiesForReading () {
        self.properties = getPropertyCollector().getProperties()
    }
    
    func updateDescriptions () {
        self.descriptions = getDescriptionContents()
    }
    

    
    // Properties
    func createInitialProperty (valueType:ValueType, valueAmount:Int) {
        PropertyStore.addProperty(
            valueType: valueType,
            valueAmount: valueAmount,
            durationType: .Eternal,
            durationAmount: 1,
            targets: self)
    }
    
    func getPropertyValue(valueType: ValueType) -> Int  {
        return properties
            .filter{$0.value.type == valueType}
            .reduce(0) {$0 + $1.value.amount}
    }
    
    private func getPropertyCollector () -> PropertyCollector {
        let collector = PropertyCollector(target: self)
        PropertyStore.visitedBy(collector: collector)
        return collector
    }
    
    // Experience
    func addExperience(experienceTag :String) {
        ExperienceStore.addExperience(gameEntity: self, experience: experienceTag)
    }
    
    func hasExperience(experienceTag :String) -> Bool {
        ExperienceStore.experienced(gameEntity: self, experience: experienceTag)
    }
    
    
    // Descriptions
    
    func describe () {
        print(getDescriptionContents().first?.text ?? "- no description on \(id) -")
    }
    
    func addDescription (text :String,
                         image :String? = "",
                         imageText :String? = "",
                         vignette :String? = "",
                         conditions :[Condition]) {
        let descriptionContent = DescriptionContent(text: text, image: image!, imageText: imageText!, vignette: vignette!)
        DescriptionStore.add(description: Description(conditions: conditions, content: descriptionContent, target: self))
    }
    
    func getDescriptionContents() -> [DescriptionContent] {
        self.getDescriptionCollector().descriptionContents
    }
    
    private func getDescriptionCollector() -> DescriptionCollector {
        let descriptionCollector = DescriptionCollector(target: self)
        DescriptionStore.visitedBy(descriptionCollector: descriptionCollector)
        return descriptionCollector
    }
}

class PropertyCollector {
    let target :GameEntity
    var properties : [Property] = []

    init(target: GameEntity) {
        self.target = target
    }
    
    func addProperty (property: Property){
        properties.append(property)
    }
    
    func getPropertyValueFor(valueType:ValueType) -> Int {
        return properties
            .filter{$0.value.type == valueType}
            .reduce(0) {$0 + $1.value.amount}
    }
    
    func getProperties() -> [Property] {
        return self.properties
    }
}


class DescriptionCollector {
    let target :GameEntity
    var descriptionContents : [DescriptionContent] = []

    init(target: GameEntity) {
        self.target = target
    }
    
    func addDescriptionContent (descriptionContent: DescriptionContent){
        descriptionContents.append(descriptionContent)
    }
    
    
}
