//
//  RestaurantVoucher.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    var restaurant: Restaurant
    
//    var isMini: Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(spacing: 30) {
                
                AsyncImage(url: URL(string: restaurant.image), content: { image in
                    
                    image.resizable().overlay(alignment: .bottomLeading, content: {
                        VStack {
                            Text(restaurant.name).bold().font(.system(size: 12)).foregroundColor(.white)
                        }.padding()
                    })

                    
                }, placeholder: {
                    
                    Text("Still loading ...").bold().padding().foregroundColor(.white).background(.yellow).cornerRadius(9)

                }).frame(width: 325, height: 210).background(.black).cornerRadius(9)
                                
            }.padding().background( .orange )
        }.background(.yellow)
    }
}

#Preview {
    RestaurantDetailView(restaurant: Restaurant(description: "TryingRestaurang", id: "5", image: "https://lh5.googleusercontent.com/p/AF1QipNCq1B7QPIZOpzH6Yu-U33xfzu5W28hYJKd7xXq=w408-h306-k-no", location: Location(latitude: 59.30465856210876, longitude: 18.03055060891921), name: "Eriks pizzeria", openingHours: "10 a.m. - 9 p.m.", rating: 7, reviews: [ OpinionsView(name: "John", opinions: "I am glad for its meals.", restaurantId: "restaurantId2", showPopup: .constant(false)) ] ))
    
    
}
