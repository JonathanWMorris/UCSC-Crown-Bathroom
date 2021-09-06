//
//  FloorView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct FloorView: View {
    
    let house: House
    let floor: Floor
    
    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(gradient: Gradient(colors: [Color(hex: floor.hexColor1),
                                                       Color(hex: floor.hexColor2)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            HStack(){
                Text(Image(systemName: floor.symbolName))
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(.leading, 40)
                Text(floor.id)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 40)
            }
            .foregroundColor(.white)
            .shadow(color: .black, radius: 2, x: 0, y: 0)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: .black, radius: 5, x: 3, y: 3)
    }
}

struct FloorView_Previews: PreviewProvider {
    static var previews: some View {
        FloorView(house: House(id: "Descartes", hexColor1: "08313A", hexColor2: "5CD85A", symbolName: "house"), floor: Floor(id: "First", number: 1, symbolName: "1.circle",
                               hexColor1: "08313A", hexColor2: "5CD85A"))
            .frame(height: 100, alignment: .center)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
