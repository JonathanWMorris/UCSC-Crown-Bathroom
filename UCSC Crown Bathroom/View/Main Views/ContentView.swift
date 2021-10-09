//
//  ContentView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/3/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    @StateObject var signInViewModel: SignInViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var columns: [GridItem] {
        if sizeClass == .regular{
            return [
                GridItem()
            ]
        }else{
            return [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100))
            ]
        }
        
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(contentViewModel.houses) { house in
                        NavigationLink(
                            destination: FloorsView(signInViewModel: signInViewModel, house: house),
                            label: {
                                HouseView(house: house)
                            })
                            .frame(height: 140)
                            .padding(5)
                    }
                }
                .padding(.horizontal, 5)
            }
            .animation(.easeIn)
            .navigationTitle("Select House")
            FloorsView(signInViewModel: signInViewModel, house: contentViewModel.houses.first ?? House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: ""))
        }
        .onAppear{
            contentViewModel.getHouseListData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(signInViewModel: SignInViewModel())
    }
}
