//
//  ConfirmationPage.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import SwiftUI

struct ConfirmationPage: View {
    
    @StateObject var signInViewModel: SignInViewModel
    
    let wasSuccessful: Bool
    let shower: Shower
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(
                            colors: [
                                Color(hex: wasSuccessful ? "AFE1AF" : "ffbaba"),
                                Color(hex: wasSuccessful ? "7FFFD4" : "ff5252")]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                if wasSuccessful{
                    StackedDrops()
                }else{
                    RotatingIcon(systemImageName: "drop.triangle")
                        .font(.system(size: 100))
                        .padding(.top, 50)
                }
                
                Spacer()
                
                if wasSuccessful{
                    
                    Text("Confirmed!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .animation(.easeIn)
                    
                    Text("Your spot has been saved, but be quick and considerate for others who want to shower after you!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .animation(.easeIn)
                } else {
                    
                    Text("Failed")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .animation(.easeIn)
                    
                    Text("Try again selecting a different shower, this shower was taken at the last second.")
                        .font(.title3)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .animation(.easeIn)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .onDisappear {
            signInViewModel.checkForExistingShower()
        }
    }
}

struct ConfirmationPage_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationPage(signInViewModel: SignInViewModel(), wasSuccessful: true, shower: Shower(id: "Shower 1", isOccupied: false, lastUpdated: Date(), bathroom: "Main Bathroom", duration: 5, user: ""))
        
        ConfirmationPage(signInViewModel: SignInViewModel(), wasSuccessful: false, shower: Shower(id: "Shower 1", isOccupied: false, lastUpdated: Date(), bathroom: "Main Bathroom", duration: 5, user: ""))
    }
}
