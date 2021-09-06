//
//  ContentView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/3/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(contentViewModel.houses) { house in
                        NavigationLink(
                            destination: FloorsView(house: house),
                            label: {
                                HouseView(house: house)
                            })
                            .frame(height: 150)
                            .padding(5)
                    }
                }
                .padding(.horizontal, 5)
            }
            .animation(.easeIn)
            .navigationTitle("Select House")
        }
        .onAppear{
            contentViewModel.getHouseListData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
