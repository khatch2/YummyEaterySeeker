//
//  RestaurantsMapView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI
import MapKit

struct RestaurantsMapView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @Binding var viewOnMap: Bool
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.325300386430435, longitude: 18.06622395719864), span: MKCoordinateSpan(latitudeDelta: 0.30, longitudeDelta: 0.25))
    
    @State var selectedRestaurant: Restaurant?
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack (spacing: 30) {
                
                Button ("Press here") {
                    List() {
                        ForEach(dbConnection.restaurantList) { restaurant in
                            Text( restaurant.name )
                        }
                    }
                }
                
//                Map(coordinateRegion: $region, annotationItems: dbConnection.restaurantList) {
//                    restaurant in
                    
                    
//                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.location, longitude: restaurant.location.first?.longitude!!), content: {
//                        Button(action: {
//                            selectedRestaurant = restaurant
//                        }, label: {
//                            VStack {
//                                
//                                ZStack {
//                                    Circle().fill(Color.primaryColor).frame(width: 35, height: 35)
//                                    Image(systemName: "carrot").foregroundColor(Color.secondaryColor)
//                                }
//
//                                Text(restaurant.name).bold().foregroundColor(Color.primaryColor)
//                            }
//                        })
//
//                    })
//                    
//                }.ignoresSafeArea().onTapGesture {
//                    selectedRestaurant = nil
//                }.overlay(alignment: .bottom, content: {
//                    
//                    VStack  {
//                        if let selectedRestaurant = selectedRestaurant {
//                         
//                            NavigationLink(destination: RestaurantView(restaurant: selectedRestaurant), label: {
//                                
////                                RestaurantCard(restaurant: selectedRestaurant, isMini: true).padding()
//                                
//                                RestaurantVoucher(restaurant: selectedRestaurant, isMini: true).padding()
//                            })
//                            
//                        }
//                        
//                        Button(action: {
//                            viewOnMap.toggle()
//                        }, label: {
//                            Text("View on list").padding().background(Color.primaryColor).foregroundColor(Color.secondaryColor).cornerRadius(9)
//                        })
//                    }

                    
//                })
                
                
//                Text("Hello, RestaurantsMapView")
                
                VStack (spacing: 30) {
                    
                    Text("Hello, RestaurantsMapView")
                    
                    Button(action: {
                            do {
//                                try db.auth.signOut()
                                try dbConnection.SignOut()
                                
                            } catch let signOutError as NSError {
                                print("Error signing out: %@", signOutError)}
                                                    }, label: {
                                                        
                                                        Text("Log me out").bold().background(.white).cornerRadius(5).padding()
                                                    })

                    
                }.background(.brown).padding()

            }.padding().background(.orange)
        }.background(.yellow)
    }
}

#Preview {
    RestaurantsMapView(viewOnMap: .constant(true)).environmentObject(DatabaseConnection())
}
