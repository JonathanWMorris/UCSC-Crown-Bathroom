//
//  StartShowerView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import SwiftUI
import UserNotifications

struct StartView: View {
    @State var durationInMinutes: Int = 5
    @State var multiplier = 1
    
    @State var wasSuccefull = true
    @StateObject var signInViewModel: SignInViewModel
    @State var confirmed = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var startShowerViewModel = StartItemViewModel()
    
    let item: Item
    let house: House
    let floor: Floor
    
    var body: some View {
        if !confirmed{
            VStack(alignment: .leading){
                Text("Start \(item.type.rawValue)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding([.leading, .top], 10)
                    .animation(.linear)
                
                Spacer()
                
                VStack(alignment: .center){
                    Spacer()
                    
                    if item.type == .Shower{
                        ZStack{
                            Image(systemName: "drop.fill")
                                .font(.system(size: CGFloat(17 * durationInMinutes)))
                                .foregroundColor(Color(hex: "266DD3"))
                                .background(colorScheme == .light ? Color.white : Color.black)
                            
                            Text("\(durationInMinutes) Min")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: CGFloat(3.3 * Double(durationInMinutes))))
                                .offset(y: CGFloat(3.3 * Double(durationInMinutes)))
                                .shadow(radius: 10)
                        }
                        
                        HStack{
                            Spacer()
                            Stepper(value: $durationInMinutes, in: 5...20) {
                                Text("Choose Duration")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            
                            .padding(.horizontal, 30)
                            Spacer()
                        }
                        .padding(.bottom, 50)
                        
                    }else{
                        Text(Image(systemName: "stopwatch"))
                            .fontWeight(.bold)
                            .font(.system(size: CGFloat(150)))
                        
                        Text("\(durationInMinutes * multiplier) Min")
                            .fontWeight(.bold)
                            .font(.system(size: CGFloat(110)))
                        HStack{
                            Spacer()
                            Stepper(value: $multiplier, in: 1...3) {
                                if multiplier == 1{
                                    Text("\(multiplier) Load")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }else{
                                    Text("\(multiplier) Loads")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                            }
                            
                            .padding(.horizontal, 30)
                            Spacer()
                        }
                        .padding(.bottom, 50)
                    }
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            if item.type != .Shower{
                                let center = UNUserNotificationCenter.current()
                                
                                center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                                }
                                
                                
                                let content = UNMutableNotificationContent()
                                content.title = "Your Laundry is complete"
                                
                                if multiplier == 1{
                                    content.body = "The \(item.type.rawValue) has finsished 1 load."
                                }else{
                                    content.body = "The \(item.type.rawValue) has finsished \(multiplier) loads."
                                }
                                
                                let date = Date().addingTimeInterval(TimeInterval(durationInMinutes*60))
                                
                                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .minute,.hour,.second], from: date)
                                
                                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                                
                                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                
                                center.add(request) { error in
                                    print(error ?? "")
                                }
                            }
                            
                            startShowerViewModel.startShower(
                                houseName: house.id, floorName: floor.id, bathroomName: "Main Bathroom",
                                shower: item, duration: durationInMinutes * multiplier, completion: { result in
                                    
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success:
                                            wasSuccefull = true
                                        case .occupied:
                                            wasSuccefull = false
                                        case .unknown:
                                            wasSuccefull = false
                                        }
                                    }
                                    
                                    confirmed = true
                                })
                            
                        }, label: {
                            Text("Start")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(.white)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(hex: "046E8F")
                                                                    ,Color(hex: "87BFFF")]),
                                        startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .shadow(color: .black, radius: 5, x: 3, y: 3)
                        })
                            .buttonStyle(PlainButtonStyle())
                            .padding([.bottom, .top], 50)
                        Spacer()
                    }
                }
            }
            .navigationTitle(item.id)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                switch item.type {
                case .Shower:
                    durationInMinutes = 10
                    multiplier = 1
                case .Washer:
                    durationInMinutes = 35
                    multiplier = 1
                case .Dryer:
                    durationInMinutes = 45
                    multiplier = 1
                }
            }
        }
        else{
            ConfirmationPage(signInViewModel: signInViewModel, wasSuccessful: wasSuccefull, item: item)
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(
            signInViewModel: SignInViewModel(), item: Item(id: "Shower 1", isOccupied: false, lastUpdated: Date(), collectionPath: "Main Bathroom", duration: 4, user: "", type: .Shower),
            house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "house"),
            floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
        )
            .previewDevice("iPhone 13 Pro")
        
        StartView(
            signInViewModel: SignInViewModel(), item: Item(id: "Shower 1", isOccupied: false, lastUpdated: Date(), collectionPath: "Main Bathroom", duration: 4, user: "", type: .Washer),
            house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "house"),
            floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
        )
        
        StartView(
            signInViewModel: SignInViewModel(), item: Item(id: "Shower 1", isOccupied: false, lastUpdated: Date(), collectionPath: "Main Bathroom", duration: 4, user: "", type: .Dryer),
            house: House(id: "Descartes", hexColor1: "", hexColor2: "", symbolName: "house"),
            floor: Floor(id: "First", number: 1, symbolName: "1.circle", hexColor1: "", hexColor2: "")
        )
    }
}
