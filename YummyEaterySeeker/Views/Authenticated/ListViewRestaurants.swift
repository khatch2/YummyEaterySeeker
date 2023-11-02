//
//  ListViewRestaurants.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-30.
//

import SwiftUI

struct ListViewRestaurants: View {
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                                
                List() {
                    
                    ForEach(theRestaurantStations) { itemRestaurantView in
                        
                        VStack {
                            
                            HStack {
                                
                                Text(itemRestaurantView.name ?? "N/A")
                                
                                RestaurantView(db: DbConnection(), restaurantStation: itemRestaurantView)

                            }
                        }
                    }
                }
            }.background(Color.orange)
        }
    }
}

#Preview {
    ListViewRestaurants()
}
