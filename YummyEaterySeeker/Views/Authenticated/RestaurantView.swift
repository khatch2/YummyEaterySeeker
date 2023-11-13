//
//  RestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct RestaurantView: View {
    
    @EnvironmentObject var db: DbConnection
    
    var restaurant: Restaurant
    
    @State var showPopup: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView {
                
                VStack(spacing: 30) {
                    
                    ZStack() {
                        
                        GeometryReader { geometry in
                                                    
                            ScrollView {
                                
                                VStack(alignment: .leading) {
                                    
                                    AsyncImage(url: URL(string: restaurant.image ), content: {
                                        image in
                                        
                                        image.resizable().overlay(alignment: .bottomLeading, content: {
                                            
                                            VStack {
                                                
                                                Text(restaurant.name ).bold().foregroundColor(.white)
                                                
                                            }.padding()
                                        })
                                        
                                    }, placeholder: {
                                        Text("Loading...").foregroundColor(.white)
                                        
                                    }).frame(height: 340)
                                    
                                    VStack(alignment: .leading, spacing: 20) {
                                        
                                        Text(restaurant.openingHours ).font(.system(.subheadline, design: .monospaced, weight: .thin))
                                        
                                        Text(restaurant.name ).bold().font(.title)
                                        
                                        Text(restaurant.description ).background(Color.teal).padding()
                                        
                                        HStack {
                                            
                                            Text("Evaluations").bold().font(.title).background(Color.mint)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                showPopup.toggle()
                                            }, label: {
                                                Text("Add an evaluation").padding().background(.yellow).foregroundColor(.blue).cornerRadius(9)
                                            })
                                            
                                        }
                                            
                                        ForEach(restaurant.reviews) { review in
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    
                                                    Text(review.name).bold().background(.mint)
                                                    
                                                    Text(review.message).background(.mint).font(.caption).fontDesign(.monospaced)
                                                }.padding(.vertical)
                                            }
                                        
                                    }.padding()
                                    
                                }
                                
                            }.ignoresSafeArea().blur(radius: showPopup ? 2 : 0)
                            
                        }
                        

                        if showPopup {
                                                    
                            OpinionsView( restaurantId: restaurant.id, showPopup: $showPopup)
                            
                        }
                        
                    }.background(.orange)
                                    
                }.padding().background(.yellow)

                
            }
            
        }
    }
}

#Preview {
    
    RestaurantView(restaurant: Restaurant(description: "restarant's description afterall.", id: "11", image: "https://lh3.googleusercontent.com/p/AF1QipNL5LJEubSGhC9mVD_kIJuSpoEgTgQzW0Njm6_9=w600-k", location: Location(latitude: 18.02395798266904, longitude: 59.311150897492475), name: "Pizzeria Valla", openingHours: "10 a.m. - 19:00 p.m.", rating: 7, reviews: [ /* Review(id: "1", name: "Tomas", message: "It's highly recommanded") */ Evaluation(id: "1", name: "Thomas", message: "It has many delicious dishes.")]))
    
}
