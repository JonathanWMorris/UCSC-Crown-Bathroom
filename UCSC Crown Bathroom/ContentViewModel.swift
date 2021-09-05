//
//  ContentViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/3/21.
//

import Foundation
import Firebase

class ContentViewModel: ObservableObject {
    @Published var sampleData = [
        House(id: "1", name: "Descartes",
              floors: [], hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "gamecontroller"),
        House(id: "2", name: "Descartes",
              floors: [], hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "gamecontroller"),
        House(id: "3", name: "Descartes",
              floors: [], hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "gamecontroller"),
        House(id: "4", name: "Descartes",
              floors: [], hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "gamecontroller"),
        House(id: "5", name: "Descartes",
              floors: [], hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "gamecontroller"),
        House(id: "6", name: "Descartes",
              floors: [], hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "gamecontroller"),
        House(id: "7", name: "Descartes",
              floors: [], hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "gamecontroller"),
        House(id: "8", name: "Descartes",
              floors: [], hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "gamecontroller")
    ]
    
    private var db = Firestore.firestore()
    
    func fetchData() {
            db.collection("Crown").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                let house = documents.map({ (snapshot) -> House in
                    let data = snapshot.data()
                    
                    let name = data["name"] as! String
                    let symbolName = data["symbolName"] as! String
                    let hexColor1 = data["hexColor1"] as! String
                    let hexColor2 = data["hexColor2"] as! String
                    
                    return House(id: name, name: name, floors: [], hexColor1: hexColor1, hexColor2: hexColor2, symbolName: symbolName)
                })
                
                self.sampleData = house
            }
        }
}
