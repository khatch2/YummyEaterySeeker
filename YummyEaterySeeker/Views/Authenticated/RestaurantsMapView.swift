//
//  RestaurantsMapView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import Foundation
import SwiftUI
import MapKit


struct RestaurantsMapView: View {
    
    /** Sti yrkeshögskolan = 59.310230470905275, 18.021426935241518 */
    
    @State var viewTheGolobalSateliteMap = false
    
    var locationManager = LocationManager()
        
    @State var cookingChefsPersons : [Restaurant] = []
    
    @State var mapConfiguration = MKStandardMapConfiguration()
    
    @State var showAlert: Bool = true
    
    @EnvironmentObject var db: DbConnection
    
    @Binding var viewThemOnMap: Bool
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.30769909740655, longitude: 18.030594636663807), span: MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010))
    
    @State var selectedRestaurant: Restaurant?
    
    @State var myDesiedRestaurants : [MKPointOfInterestCategory] = [.restaurant]
    
    /** DONE : Changed it here to declare theRestaurantStations globally BUT WITHOUT inititilise it with "Chamsin Grill" */
    @State var theRestaurantStations: [Restaurant] = []
    
    func populateRestarantsNearByPlaces(theRegion: MKCoordinateRegion, theCookingChefs: [Restaurant]) -> String {
        
        var wantedRequest = MKLocalSearch.Request()
        
        wantedRequest.naturalLanguageQuery = "Restaurant"
        
        wantedRequest.region = theRegion
        
        var wantedSearch = MKLocalSearch(request: wantedRequest)
                
        wantedSearch.start() { /** MKLocalSerach.CompletionHandler */ (response, error) in
            
            guard let response = response else {return}
            
            if let error =  error {
                
                print(" error = ", error)
            }
            
            for item in response.mapItems {
                
                theRestaurantStations.append(Restaurant(description: item.url?.absoluteString ?? "n/a", id: item.phoneNumber ?? "n/a", image: item.url?.absoluteString ?? "n/a", location: Location(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude), name: item.name ?? "n/a", openingHours: "n/a", rating: 0, reviews: []))
                
                MapMarker(coordinate: item.placemark.coordinate)
            }
            
            print(" theRestaurantStations = ", theRestaurantStations)
            
        }
        
        return " Done, populateRestarantsNearByPlaces() "
        
    }
    
    var body: some View {
        
        GeometryReader { geometry in
                        
            VStack (alignment: .leading) {
                
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: viewTheGolobalSateliteMap ? theRestaurantStations : db.localAndGlobalRestaurantsList) {
                    restaurant in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.location.latitude, longitude: restaurant.location.longitude), content: {
                        
                        Button(action: {
                            selectedRestaurant = restaurant
                        }, label: {
                            
                            if !viewTheGolobalSateliteMap {
                            
                            Button(action: {
                                
                                print()
                                print(type(of: restaurant))
                                print("restaurant's opening hours is: " , restaurant.openingHours)
                                print()
                                
                                showAlert.toggle()
                                
                            }, label: {
                                
                                Text("⏰")}).alert(Text("Opening Hours"), isPresented: $showAlert, actions: {
                                    
                                } ).confirmationDialog("Trying2ConfirmationDialog", isPresented: $showAlert, actions: {
                                    
                                    Text(restaurant.openingHours)
                                    
                                }, message: {
                                    
                                    Text("Opening Hours: \(restaurant.openingHours) ")
                                })
                            
                            }
                            
                            ZStack {
                                
                                HStack {
                                    
                                    ZStack {
                                        
                                        Circle().fill(Color.gray).frame(width: 30, height: 30, alignment: .center)
                                        
                                        Image(systemName: "fork.knife.circle").resizable().foregroundColor(Color.red).frame(width: 26, height: 26, alignment: .center)
                                    }
                                    
                                    Text(restaurant.name).padding().background(.yellow).cornerRadius(9)
                                    
                                }
                                
                            }
                            
                        }
                               
                        )
                    })
                    
                }.mapStyle({viewTheGolobalSateliteMap ? .imagery(elevation: .realistic) : .standard}())
                    .ignoresSafeArea().onTapGesture {
                        
                        selectedRestaurant = nil
                        
                    }.overlay(alignment: .bottom, content: {
                        
                        VStack  {
                            
                            if let selectedRestaurant = selectedRestaurant {
                                
                                NavigationLink(destination: RestaurantView(restaurant:                selectedRestaurant), label: {
                                    
                                    /// DONE : Added button that sets selectedRestaurant only around the round circle with text underneath
                                    Label("More details", systemImage: "bolt.fill")
                                    
//                                     RestaurantDetailView(restaurant: selectedRestaurant).padding()
                                     
                                }).background(Color.yellow)
                            }
                            
                            Button(action: {
                                
                                var look160 = populateRestarantsNearByPlaces(theRegion: region, theCookingChefs: cookingChefsPersons)
                                print(" look160 =   ", look160)
                                
                                self.viewTheGolobalSateliteMap = true
                                
                            }, label: {
                                
                                Text(" Major resturants globally ").bold().background(.yellow).cornerRadius(9)
                                
                            })
                            
                            Button(action: {
                                
                                viewThemOnMap.toggle()
                                
                            }, label: {
                                
                                Text(" View them on list ").bold().background(.yellow).cornerRadius(9)
                                
                            })
                        }
                    })
                
                VStack (spacing: 30) {
                    
                    Button(action: {
                        
                        do {
                            
                            try db.auth.signOut()
                            
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
        
}
