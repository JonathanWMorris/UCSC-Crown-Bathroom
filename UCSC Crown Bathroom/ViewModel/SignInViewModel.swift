//
//  SignInViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/7/21.
//

import Foundation
import RealmSwift
import Firebase

class SignInViewModel: ObservableObject {
    @Published var userExists = true
    @Published var thereIsExistingShower = false
    
    let realm = try! Realm()
    private var db = Firestore.firestore()
    
    func isUserAuthenticated() {
        let users = realm.objects(User.self)
        
        if users.count != 0 {
            DispatchQueue.main.async {
                self.userExists = true
            }
        } else {
            let user = User()
            user.id = UUID().uuidString
            
            try! realm.write {
                realm.add(user)
            }
            
            DispatchQueue.main.async {
                self.userExists = true
            }
        }
    }
    
    func checkForExistingShower() {
        let showers = realm.objects(LocalShower.self)
        
        for shower in showers {
            if shower.durationLeft > 0 {
                thereIsExistingShower = true
            } else {
                let user = realm.objects(User.self).first!
                
                self.db.document(shower.firestorePath).setData([
                    "isOccupied" : false,
                    "lastUpdated" : Timestamp(date: Date()),
                    "name" : shower.name,
                    "duration" : 0,
                    "user" : user.id
                ])
                
                try! realm.write {
                    thereIsExistingShower = false
                    realm.delete(shower)
                }
            }
        }
        
        if showers.isEmpty {
            thereIsExistingShower = false
        }
    }
}
