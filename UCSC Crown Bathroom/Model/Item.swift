//
//  Shower.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import Foundation

enum ItemType: String {
    case Shower = "Shower"
    case Dryer = "Dryer"
    case Washer = "Washer"
}

class Item: Identifiable {
    let id: String
    let isOccupied: Bool
    let lastUpdated: Date
    let collectionPath: String
    let duration: Int
    let user: String
    let type: ItemType
    
    let occupiedHexColor1: String = "DC143C"
    let occupiedHexColor2: String = "F08080"
    
    let vacantHexColor1: String = "097969"
    let vacantHexColor2: String = "AFE1AF"
    
    
    var minutesSincePreviousShower: Int {
        let differenceInSecconds = Date().timeIntervalSince1970 - lastUpdated.timeIntervalSince1970
        
        return Int(differenceInSecconds / 60)
    }
    
    var durationLeft: Int {
        return duration - minutesSincePreviousShower
    }
    
    init(id: String, isOccupied:Bool, lastUpdated: Date, collectionPath: String, duration: Int, user: String, type: ItemType) {
        self.id = id
        self.isOccupied = isOccupied
        self.lastUpdated = lastUpdated
        self.collectionPath = collectionPath
        self.duration = duration
        self.user = user
        self.type = type
    }
}
