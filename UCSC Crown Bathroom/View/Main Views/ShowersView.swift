//
//  ShowersView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct ShowersView: View {
    @StateObject var showersViewModel: ShowersViewModel = ShowersViewModel()
    @StateObject var signInViewModel: SignInViewModel
    
    let house: House
    let floor: Floor
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Select Shower")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .animation(.linear)
                
                Spacer()
                Label("Live", systemImage: "record.circle")
                    .foregroundColor(.red)
            }
            .padding([.leading, .top, .trailing], 15)
            .padding(.bottom, 5)
            
            ScrollView{
                ForEach(showersViewModel.showers) { shower in
                    ShowerView(signInViewModel: signInViewModel, shower: shower, house: house, floor: floor)
                        .frame(height: 200)
                        .padding([.leading, .top, .trailing])
                }
            }
            .animation(.easeIn)
        }
        .navigationTitle("\(floor.id) Floor Showers")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            showersViewModel.timer?.invalidate()
            showersViewModel.getShowersInfo(house: house.id, floor: floor.id)
        }
        .onDisappear{
            showersViewModel.timer?.invalidate()
            showersViewModel.removeListener()
        }
    }
}

struct ShowersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ShowersView(
                showersViewModel: ShowersViewModel(),
                signInViewModel: SignInViewModel(), house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "House"),
                floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
            )
        }
    }
}
