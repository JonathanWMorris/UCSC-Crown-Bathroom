//
//  RotatingIcon.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import SwiftUI

struct RotatingIcon: View {
    @State private var isAnimating = false
    @State private var showProgress = false
    @State private var showingAlert = false
    
    let systemImageName: String
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Button(action: {
            showingAlert.toggle()
        }, label: {
            if showProgress {
                Image(systemName: systemImageName)
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                    .animation(self.isAnimating ? foreverAnimation : .default)
                    .onAppear { self.isAnimating = true }
                    .onDisappear { self.isAnimating = false }
                
            } else {
                Image(systemName: systemImageName)
            }
        })
        
        .buttonStyle(PlainButtonStyle())
        .onAppear { self.showProgress = true }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Fr Bro"), dismissButton: .default(Text("Fr Bro")))
        })
    }
}

struct RotatingIcon_Previews: PreviewProvider {
    static var previews: some View {
        RotatingIcon(systemImageName: "person.fill")
            .padding()
            .font(.system(size: 50))
            .previewLayout(.sizeThatFits)
        
        RotatingIcon(systemImageName: "drop.fill")
            .padding()
            .font(.system(size: 50))
            .previewLayout(.sizeThatFits)
    }
}
