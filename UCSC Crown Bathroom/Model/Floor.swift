//
//  Floor.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import Foundation

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
