//
//  House.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/3/21.
//

import Foundation

class House: Codable, Identifiable {
    let id: String
    let name: String
    let symbolName: String
    let hexColor1: String
    let hexColor2: String
    let floors: [Floor]
    
    
    init(id: String, name: String, floors: [Floor], hexColor1: String, hexColor2: String, symbolName: String) {
        self.id = id
        self.name = name
        self.floors = floors
        self.hexColor1 = hexColor1
        self.hexColor2 = hexColor2
        self.symbolName = symbolName
    }
}

class Floor: Codable, Identifiable {
    let id: String
    let bathrooms: [Bathroom]
    
    init(id: String, bathrooms: [Bathroom]) {
        self.id = id
        self.bathrooms = bathrooms
    }
}

class Bathroom: Codable, Identifiable {
    let id: String
    let isVacant: Bool
    
    init(id: String, isVacant:Bool) {
        self.id = id
        self.isVacant = isVacant
    }
}
