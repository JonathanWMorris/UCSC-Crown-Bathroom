//
//  FloorView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct FloorsView: View {
    @StateObject var floorViewModel = FloorViewModel()
    
    let houseName: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Select Floor")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding([.leading, .top], 15)
            
            ForEach(floorViewModel.floors) { floor in
                NavigationLink(
                    destination: Text("Work in progress"),
                    label: {
                        FloorView(floor: floor)
                            .frame(height: 100, alignment: .center)
                            .padding(.horizontal)
                    })
                    .frame(height: 150)
                    .padding(5)
            }
            
            Spacer()
        }
        .animation(.easeIn)
        .navigationTitle(houseName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            floorViewModel.getFloors(chosenHouse: houseName)
        }
    }
}

struct FloorsView_Previews: PreviewProvider {
    static var previews: some View {
        FloorsView(floorViewModel: FloorViewModel(), houseName: "Descartes")
    }
}
