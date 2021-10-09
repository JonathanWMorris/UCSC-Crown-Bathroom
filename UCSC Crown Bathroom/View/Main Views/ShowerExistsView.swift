//
//  ShowerExistsView.swift
//  ShowerExistsView
//
//  Created by Jonathan Morris on 9/7/21.
//

import SwiftUI
import RealmSwift

struct ShowerExistsView: View {
    
    @StateObject var signInViewModel: SignInViewModel
    @StateObject var showerExistsViewModel: ShowerExistsViewModel = ShowerExistsViewModel()
    
    let realm = try! Realm()
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(
                            colors: [
                                Color(hex: "AFE1AF"),
                                Color(hex: "7FFFD4")]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                    StackedDrops()
                
                Spacer()
                    
                Text("You have already booked a Shower")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .animation(.easeIn)
                        .foregroundColor(.black)
                    
                    Text("If you would like to book a shower somewhere else, cancel the previous shower.")
                        .font(.title3)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .animation(.easeIn)
                        .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    
                    let shower = realm.objects(LocalShower.self).first!
                    showerExistsViewModel.cancelShower(localShower: shower, signInViewModel: signInViewModel)
                }, label: {
                    Text("Cancel Shower")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(hex: "ff5252")
                                                            ,Color(hex: "ffbaba")]),
                                startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: .black, radius: 5, x: 3, y: 3)
                })
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 50)
            }
            .padding(.horizontal)
            .onAppear{
                signInViewModel.checkForExistingShower()
            }
        }
    }
}

struct ShowerExistsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowerExistsView(signInViewModel: SignInViewModel())
    }
}
