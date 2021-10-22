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
    let item: Item
    
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
                    if item.type == .Shower{
                        StackedDrops()
                    }else{
                        RotatingIcon(systemImageName: "ipodshuffle.gen2")
                            .font(.system(size: 100))
                            .padding(.top, 50)
                    }
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
                        .foregroundColor(.black)
                    
                    Text("Your spot has been saved for the \(item.type.rawValue)!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .animation(.easeIn)
                        .foregroundColor(.black)
                    
                } else {
                    
                    Text("Failed")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .animation(.easeIn)
                        .foregroundColor(.black)
                    
                    Text("Try again selecting a different shower, this shower was taken at the last second.")
                        .font(.title3)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .animation(.easeIn)
                        .foregroundColor(.black)
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
        ConfirmationPage(signInViewModel: SignInViewModel(), wasSuccessful: true, item: Item(id: "Shower 1", isOccupied: false, lastUpdated: Date(), collectionPath: "Main Bathroom", duration: 5, user: "", type: .Shower))
        
        ConfirmationPage(signInViewModel: SignInViewModel(), wasSuccessful: true, item: Item(id: "Shower 1", isOccupied: false, lastUpdated: Date(), collectionPath: "Main Bathroom", duration: 5, user: "", type: .Washer))
        
        ConfirmationPage(signInViewModel: SignInViewModel(), wasSuccessful: false, item: Item(id: "Shower 1", isOccupied: false, lastUpdated: Date(), collectionPath: "Main Bathroom", duration: 5, user: "", type: .Washer))
    }
}
