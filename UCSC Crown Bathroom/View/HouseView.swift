//
//  HouseView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/3/21.
//

import SwiftUI

struct HouseView: View {
    let house: House
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: house.hexColor1),Color(hex: house.hexColor2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack{
                Text(Image(systemName: house.symbolName))
                    .font(.largeTitle)
                    .fontWeight(.medium)
                
                Text(house.id)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .shadow(color: .black, radius: 2, x: 0, y: 0)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: .black, radius: 5, x: 3, y: 3)
    }
}

struct HouseView_Previews: PreviewProvider {
    static var previews: some View {
        HouseView(house: House(id: "Descartes", hexColor1: "0666FF", hexColor2: "5A5ADE", symbolName: "house"))
            .frame(width: 200, height: 200, alignment: .center)
            .previewLayout(.sizeThatFits)
            .padding(40)
        
    }
}
