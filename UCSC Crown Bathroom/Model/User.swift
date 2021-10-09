//
//  User.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/7/21.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var id: String
}

class LocalShower: Object {
    @Persisted var duration: Int
    @Persisted var started: Date
    @Persisted var firestorePath: String
    @Persisted var floor: String
    @Persisted var house: String
    @Persisted var name: String
    
    var minutesSincePreviousShower: Int {
        let differenceInSecconds = Date().timeIntervalSince1970 - started.timeIntervalSince1970
        
        return Int(differenceInSecconds / 60)
    }
    
    var durationLeft: Int {
        return duration - minutesSincePreviousShower
    }
}
