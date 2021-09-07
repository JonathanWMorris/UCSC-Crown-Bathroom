//
//  StartShowerViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import Foundation
import Firebase

class StartShowerViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    
    enum StartShowerResult {
        case success
        case occupied
        case unknown
    }
    
    func startShower(houseName: String, floorName: String,
                     bathroomName: String, shower: Shower,
                     duration: Int, completion: @escaping  (StartShowerResult) -> ()) {
        
        let path = "Crown/\(houseName)/Floors/\(floorName)/Bathrooms/\(bathroomName)/Showers"
        
        db.collection(path).document(shower.id).getDocument { snapshot, error in
            guard error == nil else { return completion(.unknown) }
            guard let snapshot = snapshot else { return completion(.unknown) }
            guard let data = snapshot.data() else { return completion(.unknown) }
            
            let isOcupied = data["isOccupied"] as! Bool
            
            if isOcupied {
                return completion(.occupied)
            }else{
                self.db.collection(path).document(shower.id).setData(
                    [
                        "isOccupied" : true,
                        "lastUpdated" : Timestamp(date: Date()),
                        "name" : shower.id,
                        "duration" : duration
                    ]
                )
                
                return completion(.success)
            }
        }
        

    }
}
