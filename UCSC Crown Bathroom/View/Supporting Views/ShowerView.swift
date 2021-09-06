//
//  ShowerView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct ShowerView: View {
    let shower: Shower
    let house: House
    let floor: Floor
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(
                            colors: [
                                Color(hex: shower.isOccupied ? shower.occupiedHexColor1 :
                                        shower.vacantHexColor1),
                                Color(hex: shower.isOccupied ? shower.occupiedHexColor2 :
                                        shower.vacantHexColor2)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            HStack{
                VStack{
                    Text(Image(systemName: shower.isOccupied ? "person.fill" : "checkmark"))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Text(shower.id)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Text(shower.isOccupied ? "Occupied" : "Vacant")
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
                .padding([.vertical, .leading], 30)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2, x: 0, y: 0)
                
                Spacer()
                
                if shower.isOccupied{
                    Text("\(shower.minutesSincePreviousShower) Minutes Ago")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 0)
                        .padding(30)
                }
                
                if !shower.isOccupied {
                    NavigationLink(
                        destination: StartShowerView(shower: shower, house: house, floor: floor),
                        label: {
                            Text("Start")
                                .padding(30)
                                .font(.title)
                                .background(Color(.white))
                                .foregroundColor(Color(hex: shower.vacantHexColor1))
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                .shadow(color: .black, radius: 5, x: 3, y: 3)
                        })
                        .padding(30)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct ShowerView_Previews: PreviewProvider {
    static var previews: some View {
        ShowerView(shower: Shower(id: "Shower 1", isOccupied: false, lastUpdated: Date(), bathroom: "Main Bathroom"), house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "house"), floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: ""))
            .frame( height: 200, alignment: .center)
            .padding()
            .previewLayout(.sizeThatFits)
        
        ShowerView(shower: Shower(id: "Shower 1", isOccupied: true, lastUpdated: Date(), bathroom: "Main Bathroom"), house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "house"), floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: ""))
            .frame( height: 200, alignment: .center)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
