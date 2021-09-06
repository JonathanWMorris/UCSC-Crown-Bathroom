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
        House(id: "Descartes", hexColor1: "0666FF",
              hexColor2: "5A5ADE", symbolName: "gamecontroller")
    ]
    
    private var db = Firestore.firestore()
    
    
    func getHouseListData() {
        let housesDocument = db.collection("Crown")
        
        housesDocument.getDocuments { (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                
                return
            }
            
            
            let houses = documents.map({ (snapshot) -> House in
                let data = snapshot.data()
                
                let name = data["name"] as! String
                let symbolName = data["symbolName"] as! String
                let hexColor1 = data["hexColor1"] as! String
                let hexColor2 = data["hexColor2"] as! String
                
                return House(id: name, hexColor1: hexColor1, hexColor2: hexColor2, symbolName: symbolName)
            })
            
            
            DispatchQueue.main.async {
                self.sampleData = houses
            }
        }
    }
}
