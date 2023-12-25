//
//  Plant.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/16/23.
//

import Foundation
import SwiftData

enum Lighting: Codable{
    case low
    case moderate
    case direct
    case brightIndirect
    case lowToMedium
}
enum Frequency: Codable, Hashable{
    case xDays(Int)
    case xWeeks(Int)
    case xMonths(Int)
}

@Model
final class Plant{
    static var nextID = 0
    let id: Int
    var datePlanted: Date
    var lastWatered: Date
    var frequency: Frequency
    var name: String
    var species: String
    var light: Lighting
    var lastPruned: Date?
    var lastFertilized: Date?
    
    init(datePlanted: Date, frequency: Frequency, name: String, species: String, light: Lighting, lastPruned: Date?, lastFertilized: Date?) {
        id = Plant.nextID
        Plant.nextID += 1
        self.datePlanted = datePlanted
        self.lastWatered = datePlanted
        self.frequency = frequency
        self.name = name
        self.species = species
        self.light = light
    }
}
