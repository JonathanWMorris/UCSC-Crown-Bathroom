//
//  UCSC_Crown_BathroomApp.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/3/21.
//

import SwiftUI
import Firebase
import RealmSwift
import AppTrackingTransparency

@main
struct UCSC_Crown_BathroomApp: SwiftUI.App {
    
    init() {
        FirebaseApp.configure()
        
        let config = Realm.Configuration(schemaVersion: 3, migrationBlock:{migration, oldSchema in
            if oldSchema < 3{
                migration.deleteData(forType: "User")
            }
            if oldSchema < 2{
                migration.deleteData(forType: "LocalShower")
            }
        })
        
        Realm.Configuration.defaultConfiguration = config
        
    }
    
    @StateObject var signInViewModel = SignInViewModel()
    
    var body: some Scene {
        WindowGroup {
            VStack{
                if signInViewModel.userExists{
                    if signInViewModel.thereIsExistingShower{
                        ShowerExistsView(signInViewModel: signInViewModel)
                            .animation(.easeIn)
                    } else {
                        ContentView(signInViewModel: signInViewModel)
                            .animation(.easeIn)
                    }
                }
            }
            .onAppear{
                signInViewModel.isUserAuthenticated()
                signInViewModel.checkForExistingShower()
                
                ATTrackingManager.requestTrackingAuthorization { status in
                    print(status)
                }
            }
        }
    }
}
