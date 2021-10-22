//
//  StartShowerViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import Foundation
import Firebase
import RealmSwift

enum StartItemResult {
    case success
    case occupied
    case unknown
}

class StartItemViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    
    let realm = try! Realm()
    
    func startShower(houseName: String, floorName: String,
                     bathroomName: String, shower: Item,
                     duration: Int, completion: @escaping  (StartItemResult) -> ()) {
        
        let path = shower.collectionPath
        
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
                        "duration" : duration,
                        "user" : self.realm.objects(User.self).first!.id
                    ]
                )
                
                if shower.type == .Shower{
                    let localShower = LocalShower()
                    localShower.started = Date()
                    localShower.duration = duration
                    localShower.firestorePath = path
                    localShower.floor = floorName
                    localShower.house = houseName
                    localShower.name = shower.id
                    
                    try! self.realm.write({
                        self.realm.add(localShower)
                    })
                }
                
                return completion(.success)
            }
        }
    }
}
