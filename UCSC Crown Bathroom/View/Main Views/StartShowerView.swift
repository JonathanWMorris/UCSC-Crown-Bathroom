//
//  StartShowerView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import SwiftUI

struct StartShowerView: View {
    @State var durationInMinutes: Int = 5
    @State var confirmationSheetIsShown = false
    @State var wasSuccefull = true
    
    @StateObject var startShowerViewModel = StartShowerViewModel()
    
    let shower: Shower
    let house: House
    let floor: Floor
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Start Shower")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding([.leading, .top], 15)
                .animation(.linear)
            
            Spacer()
            
            VStack(alignment: .center){
                
                ZStack{
                    Image(systemName: "drop.fill")
                        .font(.system(size: CGFloat(20 * durationInMinutes)))
                        .foregroundColor(Color(hex: "266DD3"))
                        .background(Color.white)
                    
                    Text("\(durationInMinutes) Min")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: CGFloat(3.5 * Double(durationInMinutes))))
                        .offset(y: CGFloat(3.5 * Double(durationInMinutes)))
                        .shadow(radius: 10)
                }
                
                HStack{
                    Spacer()
                    Stepper(value: $durationInMinutes, in: 5...20) {
                        Text("Choose Duration")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    
                    .padding(.horizontal, 30)
                    Spacer()
                }
                .padding(.bottom, 50)
                
                Button(action: {
                    startShowerViewModel.startShower(
                        houseName: house.id, floorName: floor.id, bathroomName: "Main Bathroom",
                        shower: shower, duration: durationInMinutes, completion: { result in
                        
                        DispatchQueue.main.async {
                            switch result {
                            case .success:
                                wasSuccefull = true
                                confirmationSheetIsShown = true
                                
                            case .occupied:
                                wasSuccefull = false
                                confirmationSheetIsShown = true
                                
                            case .unknown:
                                wasSuccefull = false
                                confirmationSheetIsShown = true
                            }
                        }
                    })
                    confirmationSheetIsShown = true
                }, label: {
                    Text("Start")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(hex: "046E8F")
                                                            ,Color(hex: "87BFFF")]),
                                startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: .black, radius: 5, x: 3, y: 3)
                })
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 50)
            }
        }
        .navigationTitle(shower.id)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $confirmationSheetIsShown, content: {
            ConfirmationPage(wasSuccessful: wasSuccefull, shower: shower)
        })
    }
}

struct StartShowerView_Previews: PreviewProvider {
    static var previews: some View {
        StartShowerView(
            shower: Shower(id: "Shower 1", isOccupied: false, lastUpdated: Date(), bathroom: "Main Bathroom", duration: 4),
            house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "house"),
            floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
        )
    }
}
