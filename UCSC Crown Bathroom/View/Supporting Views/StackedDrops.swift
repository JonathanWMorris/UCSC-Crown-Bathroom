//
//  StackedDrops.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/6/21.
//

import SwiftUI

struct StackedDrops: View {
    var body: some View {
        VStack{
            HStack{
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
            }
            .font(.system(size: 50))
            .foregroundColor(.blue)
            .shadow(radius: 5)
            .padding(.top)
            
            HStack{
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
            }
            .font(.system(size: 50))
            .foregroundColor(.blue)
            .shadow(radius: 5)
            .padding(.top)
            
            HStack{
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
                RotatingIcon(systemImageName: "drop.fill")
            }
            .font(.system(size: 50))
            .foregroundColor(.blue)
            .shadow(radius: 5)
            .padding(.top)
            HStack{
                RotatingIcon(systemImageName: "drop.fill")
            }
            .font(.system(size: 50))
            .foregroundColor(.blue)
            .shadow(radius: 5)
            .padding(.top)
        }
    }
}

struct StackedDrops_Previews: PreviewProvider {
    static var previews: some View {
        StackedDrops()
    }
}
