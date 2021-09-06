//
//  ShowersViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import Foundation
import Firebase

class ShowersViewModel: ObservableObject {
    @Published var showers: [Shower] = []
    
    private var db = Firestore.firestore()
    
    func getShowersInfo(house: String, floor: String) {
        db.collection("Crown/\(house)/Floors/\(floor)/Bathrooms/Main Bathroom/Showers").addSnapshotListener { snapshot, error in
            guard (error == nil) else { fatalError() }
            
            guard let snapshot = snapshot else { fatalError() }
            
            let documents = snapshot.documents
            
            let showers = documents.map { (snapshot) -> Shower in
                let data = snapshot
                
                let id = data["name"] as! String
                let isOccupied = data["isOccupied"] as! Bool
                let lastUpdated = data["lastUpdated"] as! Timestamp
                let bathroom = "Main Bathroom"
                
                return Shower(id: id, isOccupied: isOccupied, lastUpdated: lastUpdated.dateValue(), bathroom: bathroom)
            }
            
            DispatchQueue.main.async {
                self.showers = showers
            }
        }
    }
}
