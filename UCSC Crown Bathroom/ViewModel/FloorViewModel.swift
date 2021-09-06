//
//  FloorViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import Foundation
import Firebase

class FloorViewModel: ObservableObject {
    @Published var floors:[Floor] = []
    
    private var db = Firestore.firestore()
    
    func getFloors(chosenHouse: String) {
        let housesDocument = db.collection("Crown/\(chosenHouse)/Floors")
        
        
        housesDocument.getDocuments { (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                
                return
            }
            
            var floors = documents.map { (snapshot) -> Floor in
                let data = snapshot.data()
                
                let name = data["name"] as! String
                let symbolName = data["symbolName"] as! String
                let hexColor1 = data["hexColor1"] as! String
                let hexColor2 = data["hexColor2"] as! String
                
                var number: Int {
                    switch name {
                    case "First":
                        return 1
                    case "Second":
                        return 2
                    case "Third":
                        return 3
                    default:
                        fatalError()
                    }
                }
                
                return Floor(id: name, number: number, symbolName: symbolName, hexColor1: hexColor1, hexColor2: hexColor2)
            }
            
            floors.sort(by: {$0.number > $1.number})
            
            DispatchQueue.main.async {
                self.floors = floors
            }
        }
    }
}
