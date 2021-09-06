//
//  House.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/3/21.
//

import Foundation

class House: Codable, Identifiable {
    let id: String
    let symbolName: String
    let hexColor1: String
    let hexColor2: String
    
    init(id: String, hexColor1: String, hexColor2: String, symbolName: String) {
        self.id = id
        self.hexColor1 = hexColor1
        self.hexColor2 = hexColor2
        self.symbolName = symbolName
    }
}

class Floor: Codable, Identifiable {
    let id: String
    let number: Int
    let symbolName: String
    let hexColor1: String
    let hexColor2: String
    
    init(id: String, number:Int, symbolName: String, hexColor1:String, hexColor2:String) {
        self.id = id
        self.number = number
        self.symbolName = symbolName
        self.hexColor1 = hexColor1
        self.hexColor2 = hexColor2
    }
}

class Bathroom: Codable, Identifiable {
    let id: String
    let isVacant: Bool
    let lastUpdated: Date
    
    init(id: String, isVacant:Bool, lastUpdated: Date) {
        self.id = id
        self.isVacant = isVacant
        self.lastUpdated = lastUpdated
    }
}
