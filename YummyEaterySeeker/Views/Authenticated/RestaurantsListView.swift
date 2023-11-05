//
//  RestaurantsListView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct RestaurantsListView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var viewOnMap = false
    
    var body: some View {
        
//        GeometryReader { geometry in
//            
//            VStack(spacing: 30) {
                
                ZStack {
                    
                    ScrollView {
                        
                        Text("Restaurants").bold().font(.title)
                        
                        Spacer()
                        
                        ForEach(dbConnection.restaurantList) { restaurant in
                            
                            NavigationLink(destination: RestaurantView(restaurant: restaurant), label: {
                                RestaurantVoucher(restaurant: restaurant, isMini: false)
                            })
                        }
                        
                    }.overlay(alignment: .bottom,
                              content: {
                        
                        Button(action: {
                            viewOnMap.toggle()
                            
                        }, label: {
                            
                            Text("View on map").padding().background(.orange).foregroundColor(.purple).cornerRadius(9)
                        })
                        
                    })
                    
                    if viewOnMap {
                        RestaurantsMapView(viewOnMap: $viewOnMap)
                    }
                    
                    VStack (spacing: 30) {
                        
                        Text("Hello, RestaurantsListView")
                        
                        Button(action: {
                                do {
    //                                try db.auth.signOut()
                                    try dbConnection.SignOut()
                                    
                                } catch let signOutError as NSError {
                                    print("Error signing out: %@", signOutError)}
                                                        }, label: {
                                                            
                                                            Text("Log out me").bold().background(.white).cornerRadius(5).padding()
                                                        })

                        
                    }.background(.brown).padding()
                }
            }
        }
//    }
//}

#Preview {
    RestaurantsListView()
}
