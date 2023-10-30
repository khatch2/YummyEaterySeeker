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
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
                List() {
                    ForEach(theRestaurantStations) { item in
                        Text(item.url?.absoluteString ?? "N/A")
                    }
                }

            }
        }
    }
}

#Preview {
    ListViewRestaurants()
}
