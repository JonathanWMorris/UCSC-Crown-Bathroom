//
//  Shower.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import Foundation

class Shower: Identifiable {
    let id: String
    let isOccupied: Bool
    let lastUpdated: Date
    let bathroom: String
    let duration: Int
    let user: String
    
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
    
    init(id: String, isOccupied:Bool, lastUpdated: Date, bathroom: String, duration: Int, user: String) {
        self.id = id
        self.isOccupied = isOccupied
        self.lastUpdated = lastUpdated
        self.bathroom = bathroom
        self.duration = duration
        self.user = user
    }
}
