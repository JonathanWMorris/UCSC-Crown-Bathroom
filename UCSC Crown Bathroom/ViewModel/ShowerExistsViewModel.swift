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
        let path = "\(localShower.firestorePath)/\(localShower.name)"
        db.document(path).getDocument { snapshot, error in
            guard error == nil else { fatalError() }
            guard let snapshot = snapshot else { fatalError() }
            
            let shower = snapshot.data().map { (data) -> Item in
                
                let name = data["name"] as! String
                let isOccupied = data["isOccupied"] as! Bool
                let lastUpdated = data["lastUpdated"] as! Timestamp
                let path = localShower.firestorePath
                let duration = data["duration"] as! Int
                let user = data["user"] as! String
                
                var type: ItemType {
                    if name.contains("Shower"){
                        return .Shower
                    }
                    else if name.contains("Dryer"){
                        return .Dryer
                    }
                    else{
                        return .Washer
                    }
                }
                
                return Item(id: name, isOccupied: isOccupied, lastUpdated: lastUpdated.dateValue(), collectionPath: path, duration: duration, user: user, type: type)
            }
            
            let user = self.realm.objects(User.self).first!
            
            if shower!.user == user.id {
                self.db.document(path).setData([
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
