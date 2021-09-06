//
//  House.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/3/21.
//

import Foundation

class House: Identifiable {
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

class Floor: Identifiable {
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

class Shower: Identifiable {
    let id: String
    let isOccupied: Bool
    let lastUpdated: Date
    let bathroom: String
    
    let occupiedHexColor1: String = "DC143C"
    let occupiedHexColor2: String = "F08080"
    
    let vacantHexColor1: String = "097969"
    let vacantHexColor2: String = "AFE1AF"
    
    var minutesSincePreviousShower: Int {
        let differenceInSecconds = Date().timeIntervalSince1970 - lastUpdated.timeIntervalSince1970
        
        return Int(differenceInSecconds / 60)
    }
    
    init(id: String, isOccupied:Bool, lastUpdated: Date, bathroom: String) {
        self.id = id
        self.isOccupied = isOccupied
        self.lastUpdated = lastUpdated
        self.bathroom = bathroom
    }
}
