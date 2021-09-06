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
