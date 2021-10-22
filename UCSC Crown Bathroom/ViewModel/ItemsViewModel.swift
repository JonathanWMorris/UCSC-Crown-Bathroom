//
//  ShowersViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import Foundation
import Firebase
import RealmSwift

class ItemsViewModel: ObservableObject {
    @Published var items: [Item] = []
    var path = ""
    var timer: Timer?
    
    private var db = Firestore.firestore()
    
    var listener : ListenerRegistration? = nil
    let realm = try! Realm()
    
    func getItemsInfo(house: String, floor: String) {
        
        path = "Crown/\(house)/Floors/\(floor)/Bathrooms/Main Bathroom/Showers"
        
        if floor == "Basement"{
            path = "Crown/\(house)/Floors/\(floor)/Rooms/Laundry Room/Washers Dryers"
        }
        
        listener = db.collection(path).addSnapshotListener { snapshot, error in
            guard (error == nil) else { fatalError() }
            
            guard let snapshot = snapshot else { fatalError() }
            
            let documents = snapshot.documents
            
            let items = documents.map { (snapshot) -> Item in
                let data = snapshot
                
                let id = data["name"] as! String
                let isOccupied = data["isOccupied"] as! Bool
                let lastUpdated = data["lastUpdated"] as! Timestamp
                let collectionPath = "\(self.path)"
                let duration = data["duration"] as! Int
                let user = data["user"] as? String ?? ""
                
                var type: ItemType {
                    if id.contains("Shower"){
                        return .Shower
                    }
                    else if id.contains("Dryer"){
                        return .Dryer
                    }
                    else{
                        return .Washer
                    }
                }
                
                return Item(id: id, isOccupied: isOccupied, lastUpdated: lastUpdated.dateValue(), collectionPath: collectionPath, duration: duration, user: user, type: type)
            }
            
            DispatchQueue.main.async {
                self.items = items
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
        for shower in items{
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
