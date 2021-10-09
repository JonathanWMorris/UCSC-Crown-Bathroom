//
//  FloorView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct FloorsView: View {
    @StateObject var floorViewModel = FloorViewModel()
    @StateObject var signInViewModel: SignInViewModel
    
    let house: House
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Select Floor")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding([.leading, .top], 15)
                .animation(.linear)
            
            VStack{
                ScrollView{
                    ForEach(floorViewModel.floors) { floor in
                        NavigationLink(
                            destination: ShowersView(signInViewModel: signInViewModel, house: house, floor: floor),
                            label: {
                                FloorView(house: house, floor: floor)
                                    .padding()
                                    .frame(height: 175)
                                    .padding(.top, 10)
                            })
                    }

                }
            }
            .animation(.easeIn)
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
            floorViewModel: FloorViewModel(), signInViewModel: SignInViewModel(),
            house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "House")
        )
    }
}
