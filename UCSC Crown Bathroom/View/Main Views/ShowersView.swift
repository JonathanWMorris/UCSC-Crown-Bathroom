//
//  ShowersView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/5/21.
//

import SwiftUI

struct ShowersView: View {
    @StateObject var showersViewModel: ShowersViewModel = ShowersViewModel()
    @State var showingAlert = false
    
    let house: House
    let floor: Floor
    
    var body: some View {
        VStack(alignment: .leading){
            
            Button(action: {
                showingAlert.toggle()
            }, label: {
                Text("Select Shower")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding([.leading, .top], 15)
                    .animation(.linear)
            })
            .buttonStyle(PlainButtonStyle())
            
            HStack{
                Label("Live", systemImage: "record.circle")
                    .foregroundColor(.red)
                    .padding([.leading, .top, .bottom])
                Spacer()
            }
            
            VStack{
                ForEach(showersViewModel.showers) { shower in
                    ShowerView(shower: shower, house: house, floor: floor)
                        .padding()
                }
            }
            .animation(.easeIn)
            
            Spacer()
        }
        .navigationTitle("\(floor.id) Floor Showers")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            showersViewModel.timer?.invalidate()
            showersViewModel.getShowersInfo(house: house.id, floor: floor.id)
        }
        .onDisappear{
            showersViewModel.timer?.invalidate()
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Goth-ham"), dismissButton: .default(Text("goth daddy ham")))
        })
    }
}

struct ShowersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ShowersView(
                showersViewModel: ShowersViewModel(),
                house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "House"),
                floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
            )
        }
    }
}
