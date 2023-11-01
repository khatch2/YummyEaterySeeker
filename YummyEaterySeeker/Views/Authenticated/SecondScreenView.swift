//
//  SecondScreenView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-01.
//

import SwiftUI

struct SecondScreenView: View {
    
    var restaurantStation : RestaurantStation?
    
    var body: some View {
        
        VStack {
            
            if let restaurantStation = restaurantStation {
                
                Text("Photo of \(restaurantStation.name)")

            }
        }
    }
}

#Preview {
    SecondScreenView()
}
