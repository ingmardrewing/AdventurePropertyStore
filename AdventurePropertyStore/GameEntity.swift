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
        self.getPropertyCollector().getPropertyValueFor(valueType: valueType)
    }
    
    func getDescriptionContents() -> [DescriptionContent] {
        self.getDescriptionCollector().descriptionContents
    }
    
    private func getDescriptionCollector() -> DescriptionCollector {
        let descriptionCollector = DescriptionCollector(target: self)
        DescriptionStore.visitedBy(descriptionCollector: descriptionCollector)
        return descriptionCollector
    }
    
    private func getPropertyCollector () -> PropertyCollector {
        let descriptor = PropertyCollector(target: self)
        PropertyStore.visitedBy(descriptor: descriptor)
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
