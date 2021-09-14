//
//  ShowerExistsViewModel.swift
//  ShowerExistsViewModel
//
//  Created by Jonathan Morris on 9/7/21.
//

import Foundation
import RealmSwift
import Firebase

class ShowerExistsViewModel: ObservableObject {
    
    
    private var db = Firestore.firestore()
    let realm = try! Realm()
    
    func cancelShower(localShower: LocalShower, signInViewModel: SignInViewModel) {
        
        db.document(localShower.firestorePath).getDocument { snapshot, error in
            guard error == nil else { fatalError() }
            guard let snapshot = snapshot else { fatalError() }
            
            let shower = snapshot.data().map { (data) -> Shower in
                let name = data["name"] as! String
                let isOccupied = data["isOccupied"] as! Bool
                let lastUpdated = data["lastUpdated"] as! Timestamp
                let bathroom = "Main Bathroom"
                let duration = data["duration"] as! Int
                let user = data["user"] as! String
                
                
                return Shower(id: name, isOccupied: isOccupied, lastUpdated: lastUpdated.dateValue(), bathroom: bathroom, duration: duration, user: user)
            }
            
            let user = self.realm.objects(User.self).first!
            
            if shower!.user == user.id {
                self.db.document(localShower.firestorePath).setData([
                    "isOccupied" : false,
                    "lastUpdated" : Timestamp(date: Date()),
                    "name" : shower!.id,
                    "duration" : 0,
                    "user" : user.id
                ])
                
                print("Removing")
                
                try! self.realm.write({
                    self.realm.delete(localShower)
                })
                
                signInViewModel.checkForExistingShower()
            }
            
        }
    }
}
