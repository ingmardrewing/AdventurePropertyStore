//
//  PropertyStore.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 29.04.23.
//

import Foundation

class PropertyStore {
    static var properties : [Property] = []
    
    static func clearAll () {
        PropertyStore.properties = []
    }
    
    /**
     * Reduces the duration integer on each limited property,
     * so that effects, that are only active for a limited timespan, actually wear off.
     */
    static func endTurn () {
        properties = properties
            .map {
                if($0.duration.type == .Limited){
                    return Property(
                        targets: $0.targets,
                        value: $0.value,
                        duration: Duration(type: $0.duration.type,
                                           turns: $0.duration.turns - 1))
                }
                return $0
            }.filter {
                $0.duration.turns > 0
            }
    }

    static func addProperty (valueType:ValueType,
                         valueAmount:Int,
                         durationType:DurationType,
                         durationAmount:Int,
                         targets: GameEntity...){
        let weakTargets : [Weak<GameEntity>] = targets.map { Weak(value: $0) }
        let p = Property(targets: weakTargets,
                        value: Value(
                            type:valueType,
                            amount: valueAmount),
                        duration: Duration(
                            type: durationType,
                            turns: durationAmount))
        properties.append(p)
    }
    
    static func visitedBy (collector: PropertyCollector) {
        PropertyStore.properties.forEach {
            $0.visitedBy(collector: collector)
        }
    }

}

class Weak<T: AnyObject> {
  weak var referencedEntity : T?
  init (value: T) {
    self.referencedEntity = value
  }
}

enum ValueType :Equatable {
    case Health, Strength, Intelligence, Dexterity, Experience
}

struct Value {
    var type : ValueType
    var amount : Int
}

enum DurationType : Equatable {
    case Eternal, Limited
}

struct Duration {
    var type : DurationType
    var turns : Int
}

struct Property {
    var targets : [Weak<GameEntity>]
    var value : Value
    var duration : Duration
    
    func visitedBy (collector: PropertyCollector){
        if(self.targets.contains(where: {$0.referencedEntity == collector.target})) {
            print("xxxx")
            collector.addProperty(property: self)
        }
    }
}
