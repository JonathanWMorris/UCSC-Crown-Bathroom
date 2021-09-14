//
//  ShowersViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import Foundation
import Firebase
import RealmSwift

class ShowersViewModel: ObservableObject {
    @Published var showers: [Shower] = []
    var path = ""
    var timer: Timer?
    
    private var db = Firestore.firestore()
    
    var listener : ListenerRegistration? = nil
    let realm = try! Realm()
    
    func getShowersInfo(house: String, floor: String) {
        
        path = "Crown/\(house)/Floors/\(floor)/Bathrooms/Main Bathroom/Showers"
        
        listener = db.collection(path).addSnapshotListener { snapshot, error in
            guard (error == nil) else { fatalError() }
            
            guard let snapshot = snapshot else { fatalError() }
            
            let documents = snapshot.documents
            
            let showers = documents.map { (snapshot) -> Shower in
                let data = snapshot
                
                let id = data["name"] as! String
                let isOccupied = data["isOccupied"] as! Bool
                let lastUpdated = data["lastUpdated"] as! Timestamp
                let bathroom = "Main Bathroom"
                let duration = data["duration"] as! Int
                let user = data["user"] as? String ?? ""
                
                return Shower(id: id, isOccupied: isOccupied, lastUpdated: lastUpdated.dateValue(), bathroom: bathroom, duration: duration, user: user)
            }
            
            DispatchQueue.main.async {
                self.showers = showers
                self.timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.checkDuration), userInfo: nil, repeats: true)
                self.checkDuration()
            }
        }
    }
    
    func removeListener() {
        if let listener = listener {
            listener.remove()
        }
    }
    
    @objc func checkDuration() {
        for shower in showers{
            if shower.isOccupied && shower.durationLeft < 0 {
                self.db.collection(path).document(shower.id).setData([
                    "isOccupied" : false,
                    "lastUpdated" : Timestamp(date: Date()),
                    "name" : shower.id,
                    "duration" : 0,
                    "user" : self.realm.objects(User.self).first!.id
                ])
                print("Removing")
            }
        }
    }
}
