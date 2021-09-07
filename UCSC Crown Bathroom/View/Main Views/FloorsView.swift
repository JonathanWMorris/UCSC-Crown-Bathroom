//
//  FloorView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct FloorsView: View {
    @StateObject var floorViewModel = FloorViewModel()
    
    let house: House
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Select Floor")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding([.leading, .top], 15)
                .animation(.linear)
            
            VStack{
                ForEach(floorViewModel.floors) { floor in
                    NavigationLink(
                        destination: ShowersView(house: house, floor: floor),
                        label: {
                            FloorView(house: house, floor: floor)
                                .padding()
                                .frame(height: 200)
                                .padding(.top, 20)
                        })
                        .padding(5)
                }
            }
            .animation(.easeIn)
            
            Spacer()
        }
        .navigationTitle(house.id)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            floorViewModel.getFloors(chosenHouse: house.id)
        }
    }
}

struct FloorsView_Previews: PreviewProvider {
    static var previews: some View {
        FloorsView(
            floorViewModel: FloorViewModel(),
            house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "House")
        )
    }
}
