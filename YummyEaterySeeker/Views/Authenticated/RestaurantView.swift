//
//  RestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct RestaurantView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    var restaurant: Restaurant
    
    var body: some View {
        
        GeometryReader { geometry in 
            
            VStack(spacing: 30) {
                
                Text("Hello, RestaurantView")
                
            }.padding()
        }
    }
}

#Preview {
    RestaurantView(dbConnection: DatabaseConnection(), restaurant: Restaurant)
}
