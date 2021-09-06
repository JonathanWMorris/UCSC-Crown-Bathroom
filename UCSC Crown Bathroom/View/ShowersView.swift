//
//  ShowersView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct ShowersView: View {
    @StateObject var showersViewModel: ShowersViewModel = ShowersViewModel()
    
    let houseName:String
    let floorName: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Select Shower")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding([.leading, .top], 15)
                .animation(.linear)
            
            HStack{
                Label("Live", systemImage: "record.circle")
                    .foregroundColor(.red)
                    .padding([.leading, .top, .bottom])
                Spacer()
            }
            
            VStack{
                ForEach(showersViewModel.showers) { shower in
                    ShowerView(shower: shower)
                        .padding()
                }
            }
            .animation(.easeIn)
            
            Spacer()
        }
        .navigationTitle("\(floorName) Floor Showers")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            showersViewModel.getShowersInfo(house: houseName, floor: floorName)
        }
    }
}

struct ShowersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ShowersView(showersViewModel: ShowersViewModel(), houseName: "Descartes", floorName: "First")
        }
    }
}
