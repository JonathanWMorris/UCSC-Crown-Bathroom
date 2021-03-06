//
//  ShowerView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct ItemView: View {
    @StateObject var signInViewModel: SignInViewModel
    
    let item: Item
    let house: House
    let floor: Floor
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(
                            colors: [
                                Color(hex: item.isOccupied ? item.occupiedHexColor1 :
                                        item.vacantHexColor1),
                                Color(hex: item.isOccupied ? item.occupiedHexColor2 :
                                        item.vacantHexColor2)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            HStack{
                VStack{
                    Text(Image(systemName: item.isOccupied ? "person.fill" : "checkmark"))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Text(item.id)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Text(item.isOccupied ? "Occupied" : "Vacant")
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
                .padding([.vertical, .leading], 30)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2, x: 0, y: 0)
                
                Spacer()
                
                if item.isOccupied{
                    if item.durationLeft > 0 {
                        Text("\(item.durationLeft) Minutes Left")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 0)
                            .padding(30)
                    } else{
                        Text("Less than a minute left")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 0)
                            .padding(30)
                    }
                }
                
                if !item.isOccupied {
                    NavigationLink(
                        destination: StartView(signInViewModel: signInViewModel, item: item, house: house, floor: floor),
                        label: {
                            Text("Start")
                                .padding(30)
                                .font(.title)
                                .background(Color(.white))
                                .foregroundColor(Color(hex: item.vacantHexColor1))
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                .shadow(color: .black, radius: 5, x: 3, y: 3)
                        })
                        .padding(25)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct ShowerView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(
            signInViewModel: SignInViewModel(), item: Item(id: "Shower 1", isOccupied: false, lastUpdated: Date(), collectionPath: "Main Bathroom", duration: 0, user: "", type: .Shower),
            house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "house"),
            floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
        )
        .frame( height: 200, alignment: .center)
        .padding()
        .previewLayout(.sizeThatFits)
        
        ItemView(
            signInViewModel: SignInViewModel(), item: Item(id: "Shower 1", isOccupied: true, lastUpdated: Date(), collectionPath: "Main Bathroom", duration: 10, user: "", type: .Shower),
            house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "house"),
            floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
        )
        .frame( height: 200, alignment: .center)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
