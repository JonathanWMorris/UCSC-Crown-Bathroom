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
                    ForEach(contentViewModel.sampleData) { house in
                        NavigationLink(
                            destination: FloorsView(houseName: house.id),
                            label: {
                                HouseView(houseName: house.id,
                                          symbolName: house.symbolName,
                                          hexColor1: house.hexColor1,
                                          hexColor2: house.hexColor2)
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
