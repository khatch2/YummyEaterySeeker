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
                
            }.padding()
        }
    }
}

#Preview {
    RestaurantVoucher(restaurant: Restaurant(from: <#Decoder#>), isMini: true)
}
