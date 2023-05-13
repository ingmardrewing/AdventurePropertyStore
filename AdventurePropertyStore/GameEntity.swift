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
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    static func == (lhs: GameEntity, rhs: GameEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    func getPropertyValue(valueType: ValueType) -> Int  {
        self.getDescriptor().getPropertyValueFor(valueType: valueType)
    }
    
    func getDescriptionContents() -> [DescriptionContent] {
        self.getDescriptor().descriptionContents
    }
    
    private func getDescriptor () -> GameEntityDescriptor {
        let descriptor = GameEntityDescriptor(target: self)
        
        PropertyStore.visitedBy(descriptor: descriptor)
        DescriptionStore.visitedBy(ged: descriptor)
        
        return descriptor
    }
    
    func createInitialProperty (valueType:ValueType, valueAmount:Int) {
        PropertyStore.addProperty(
            valueType: valueType,
            valueAmount: valueAmount,
            durationType: .Eternal,
            durationAmount: 1,
            targets: self)
    }
}

class GameEntityDescriptor {
    let target :GameEntity
    var properties : [Property] = []
    var descriptionContents : [DescriptionContent] = []

    init(target: GameEntity) {
        self.target = target
    }
    
    func addProperty (property: Property){
        properties.append(property)
    }
    
    func addDescriptionContent (descriptionContent: DescriptionContent){
        descriptionContents.append(descriptionContent)
    }
    
    func getPropertyValueFor(valueType:ValueType) -> Int {
        return properties
            .filter{$0.value.type == valueType}
            .reduce(0) {$0 + $1.value.amount}
    }
    
    func getDescriptionContents() -> [DescriptionContent] {
        return descriptionContents
    }
}
