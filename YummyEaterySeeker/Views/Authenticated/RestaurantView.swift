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
    
    @State var showPopup: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in 
            
            VStack(spacing: 30) {
                
                ZStack() {
                    
                    GeometryReader { geometry in
                        
//                        Color(.systemGray6).ignoresSafeArea()
                        
                        ScrollView {
                            
                            VStack(alignment: .leading) {
                                
                                AsyncImage(url: URL(string: restaurant.image ?? "N/A"), content: {
                                    image in
                                    
                                    image.resizable().overlay(alignment: .bottomLeading, content: {
                                        
                                        VStack {
                                            Text(restaurant.name ?? "N/A").bold().font(.title).foregroundColor(.white)
                                            
                                            
                                        }.padding()
                                    })
                                    
                                }, placeholder: {
                                    Text("Loading...").foregroundColor(.white)
                                    
                                }).frame(height: 360)
                                
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    
                                    Text(restaurant.openingHours ?? "N/A").font(.system(.subheadline, design: .monospaced, weight: .thin))
                                    
                                    Text(restaurant.name ?? "N/A").bold().font(.title)
                                    
                                    Text(restaurant.description ?? "N/A")
                                    
                                    HStack {
                                        Text("Reviews").bold().font(.title)
                                        Spacer()
                                        Button(action: {
                                            showPopup.toggle()
                                        }, label: {
                                            Text("Add review").padding().background(.cyan).foregroundColor(.green).cornerRadius(9)
                                        })
                                    }
                                        
                                    ForEach(restaurant.reviews) { review in
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(review.name).bold()
                                                Text(review.message).font(.caption).fontDesign(.monospaced)
                                            }.padding(.vertical)
                                        }
                                    
                                    
                                    
                                }.padding()
                                
                            }
                        }.ignoresSafeArea().blur(radius: showPopup ? 2 : 0)
                    }
                    

                    if showPopup {
                        ReviewPopupView(restaurantId: restaurant.id, showPopup: $showPopup)
                    }
                    
                }
                
                Text("Hello, RestaurantView")
                
            }.padding()
        }
    }
}

#Preview {
    
//    RestaurantView(dbConnection: DatabaseConnection(), restaurant: Restaurant)
    
//    RestaurantView()
    
    RestaurantView(restaurant: Restaurant(description: "Hej vi är en god pizzeria", id: "11", image: "https://lh3.googleusercontent.com/p/AF1QipNL5LJEubSGhC9mVD_kIJuSpoEgTgQzW0Njm6_9=w600-k", location: [Location(latitude: 18.02395798266904, longitude: 59.311150897492475)], name: "Pizzeria Valla", openingHours: "10 a.m. - 19:00 p.m.", rating: 7, reviews: [Review(id: "1", name: "Tomas", message: "It's highly recommanded")]))
    
}
