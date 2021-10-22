//
//  ShowersView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct FloorItemsView: View {
    @StateObject var itemsViewModel: ItemsViewModel = ItemsViewModel()
    @StateObject var signInViewModel: SignInViewModel
    
    let house: House
    let floor: Floor
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                if floor.id == "Basement"{
                    Text("Select Washer/Dryer")
                        .font(.title)
                        .fontWeight(.heavy)
                        .animation(.linear)
                }else{
                    Text("Select Shower")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .animation(.linear)
                }
                Spacer()
                Label("Live", systemImage: "record.circle")
                    .foregroundColor(.red)
            }
            .padding([.leading, .top, .trailing], 15)
            .padding(.bottom, 5)
            
            ScrollView{
                ForEach(itemsViewModel.items) { shower in
                    ItemView(signInViewModel: signInViewModel, item: shower, house: house, floor: floor)
                        .frame(height: 200)
                        .padding([.leading, .top, .trailing])
                }
            }
            .animation(.easeIn)
        }
        .navigationTitle("\(floor.id) Floor Items")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            itemsViewModel.timer?.invalidate()
            itemsViewModel.getItemsInfo(house: house.id, floor: floor.id)
        }
        .onDisappear{
            itemsViewModel.timer?.invalidate()
            itemsViewModel.removeListener()
        }
    }
}

struct ShowersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FloorItemsView(
                itemsViewModel: ItemsViewModel(),
                signInViewModel: SignInViewModel(), house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "House"),
                floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
            )
        }
    }
}
