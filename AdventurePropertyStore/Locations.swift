//
//  File.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 03.06.23.
//

import Foundation

class Locations {
    var locations :[GameEntity] = []
    
    func addLocation (location :GameEntity) {
        if (locations.filter { $0 == location }.count != 0 ) {
            return
        }
        locations.append(location)
    }
}
