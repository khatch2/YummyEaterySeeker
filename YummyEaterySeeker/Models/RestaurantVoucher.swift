//
//  RestaurantVoucher.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct RestaurantVoucher: View {
    
    var restaurant: Restaurant
    
    var isMini: Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(spacing: 30) {
                
                AsyncImage(url: URL(string: restaurant.image), content: { image in
                    
                    image.resizable().overlay(alignment: .bottomLeading, content: {
                        VStack {
                            Text(restaurant.name).bold().font(.title).foregroundColor(.white)
                        }.padding()
                    })

                    
                }, placeholder: {
                    
                    Text("Still loading ...").foregroundColor(.white)

                }).frame(width: isMini ? 225 : 325, height: isMini ? 150 : 210).background(.black).cornerRadius(9)
                
                Text("Hello, RestaurantVoucher")
                
            }.padding().background( .orange )
        }.background(.yellow)
    }
}

#Preview {
    RestaurantVoucher(restaurant: Restaurant(description: "Hej vi är en god pizzeria", id: "11", image: "https://lh3.googleusercontent.com/p/AF1QipNL5LJEubSGhC9mVD_kIJuSpoEgTgQzW0Njm6_9=w600-k", location: [Location(latitude: 18.02395798266904, longitude: 59.311150897492475)], name: "Pizzeria Valla", openingHours: "10 a.m. - 19:00 p.m.", rating: 7, reviews: [Review(id: "1", name: "Tomas", message: "It's highly recommanded")]), isMini: false)
    
//    RestaurantVoucher(restaurant: Restaurant(from: <#Decoder#>), isMini: true)
}
