//
//  RestaurantsMapView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI
import MapKit

struct RestaurantsMapView: View {
    
    @State var showAlert: Bool = false
    
    @EnvironmentObject var db: DbConnection
    
    @Binding var viewThemOnMap: Bool
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.30769909740655, longitude: 18.030594636663807), span: MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010))
    
    @State var selectedRestaurant: Restaurant?
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack (alignment: .leading) {
                
                Map(coordinateRegion: $region, annotationItems: db.restaurantsList) {
                    restaurant in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.location.latitude, longitude: restaurant.location.longitude), content: {
                        
                        Button(action: {
                            selectedRestaurant = restaurant
                        }, label: {
                            
                            VStack {
                                
                                Button(action: {
                                    
                                    print()
                                    print(type(of: restaurant))
                                    print("restaurant's opening hours is: " , restaurant.openingHours)
                                    print()
                                    showAlert.toggle()
                                    
                                }, label: {
                                    Text("⏰")}).alert(Text("Opening Hours"), isPresented: $showAlert, actions: {
                                        Text(restaurant.openingHours)
                                    } )
                                
                                ZStack {
                                    Circle().fill(Color.gray).frame(width: 45, height: 45, alignment: .center)
                                    Image(systemName: "fork.knife.circle").resizable().foregroundColor(Color.red).frame(width: 40, height: 40, alignment: .center)
                                }

                                Text(restaurant.name).bold()
                            }
                        })
                    })
                    
                }.ignoresSafeArea().onTapGesture {
                    
                    selectedRestaurant = nil
                    
                }.overlay(alignment: .bottom, content: {
                    
                    VStack  {
                        
                        if let selectedRestaurant = selectedRestaurant {
                         
                            NavigationLink(destination: RestaurantView(restaurant: selectedRestaurant), label: {
                                Label("More details", systemImage: "bolt.fill")
                                /*
                                                                                                                  RestaurantDetailView(restaurant: selectedRestaurant).padding()
                                                                                                                  */
                            })
                        }
                        
                        Button(action: {
                            viewThemOnMap.toggle()
                            
                        }, label: {
                            Text("View them on list").bold().padding().background(.yellow).cornerRadius(9)
                        })
                    }
                })
                                
                VStack (spacing: 30) {
                                        
                    Button(action: {
                        
                            do {
                                
                                try db.auth.signOut()
                                
//                                try dbConnection.SignOut()
                                
                            } catch let signOutError as NSError {
                                print("Error signing out: %@", signOutError)}
                                                    }, label: {
                                                        
                                                        Text("Log me out").bold().foregroundStyle(.blue).background(.yellow).cornerRadius(5)
                                                    })
                    
                }.background(.brown)

            }.padding().background(.orange)
            
        }.background(.yellow)
    }
}

#Preview {
    RestaurantsMapView( viewThemOnMap: .constant(true)).environmentObject(DbConnection())
//    RestaurantsMapView(db: , viewThemOnMap: .constant(true))
//    RestaurantsMapView(db: DbConnection(), viewOnMap: .constant(true)).environmentObject(DatabaseConnection())
}
