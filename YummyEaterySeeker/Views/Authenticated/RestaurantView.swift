//
//  RestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-01.
//

import SwiftUI


struct RestaurantView: View {
    
    @ObservedObject var db: DbConnection
    
    @State var userImage: UIImage?
    
    var restaurantStation: RestaurantStation
    
    var body: some View {
        
        VStack {
            
            NavigationLink(destination: DetailsScreenView(restaurantStation: restaurantStation), label: {
                
                HStack {
                                        
                    if let userImage = userImage {
                        
                        AsyncImage(url: URL(string: "https://www.svtstatic.se/image/wide/992/41404046/1697528910"), content: { image in
                            image.resizable().overlay(content: {
                                VStack {
                                    Text("restaurant name i.e. db.name").bold().font(.title).foregroundColor(.white)
                                }
                            })},
                                   placeholder: {
                            Text("Loading...").foregroundColor(.white).bold()
                        })
                    }
                    
                }.foregroundColor(.white).background(Color.green)
            })
            
            
            NavigationLink(destination:
                                            
                                ShowImageView(db: db), label: {
                                Text("Show Image").bold().padding().foregroundColor(.blue).background(.yellow).cornerRadius(9)
                            })
            
            
            
        }.onAppear {
            
            print("VStack {}.onAppear {}")
            
            db.getRestaurantImage { image in
                
                self.userImage = image
                
                
                
            }
        }
    }
}
            
                
#Preview {
    RestaurantView(db: DbConnection(), restaurantStation: RestaurantStation(name: "String", latitude: 0, longitude: 0))
}
