//
//  RestaurantsListView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI
import Firebase


struct RestaurantsListView: View {
    
    @EnvironmentObject var db: DbConnection
            
    @State var viewItOnTheMap = false
    
    var body: some View {
        
        /// Authenticated NavigationStack
        NavigationStack {
            
                    GeometryReader { geometry in
                        
                        if viewItOnTheMap {
                            
                            RestaurantsMapView(viewThemOnMap: $viewItOnTheMap)
                            
                        } else {
                            
                            ScrollView(.vertical) {
                                
                                HStack {
                                    
                                    Image(systemName: "fork.knife.circle").resizable().foregroundColor(.red).background(.regularMaterial).frame(width: geometry.size.width * 0.045, height: geometry.size.height * 0.045, alignment: .center)

                                    Text("Restaurants").bold().font(.title)

                                }
                                                            
                                ForEach(db.restaurantsList) { restaurant in
                                        
                                        NavigationLink(destination: RestaurantView(restaurant: restaurant), label: {
                                            
                                                RestaurantDetailView(restaurant: restaurant)
                                            
                                        } ).frame(width: geometry.size.width, height: geometry.size.width, alignment: .center )
                                    
                                }
                                
                            }.background(.orange).overlay(alignment: .bottom,
                                      content: {
                                
                                VStack {
                                    
                                    Button(action: {
                                        
                                        viewItOnTheMap.toggle()
                                        
                                    }, label: {
                                        
                                        Text("View them on map")
                                            .bold().padding().background(.mint).foregroundColor(.blue).cornerRadius(9)
                                    })
                                    
                                    NavigationLink(destination: ShowMapFromAddressHereDotCom(), label: {
                                            Text("ShowMapFromAddress")
                                    }).bold().padding().background(.mint).foregroundColor(.blue).cornerRadius(9)
                                    
                                }
                                
                            }).position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
                            
                        }
                        
            }
        }
    }
}

#Preview {
    
    RestaurantsListView()
    
}
