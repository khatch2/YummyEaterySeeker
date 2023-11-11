//
//  RestaurantsMapView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import Foundation
import SwiftUI
import MapKit

var myDesiedRestaurants : [MKPointOfInterestCategory] = [.restaurant]

/** DONE : Change it here to declare theRestaurantStations globally BUT WITHOUT inititilise it with "Chamsin Grill" */
var theRestaurantStations: [Restaurant] = []

func populateRestarantsNearByPlaces(theRegion: MKCoordinateRegion, theCookingChefs: [Restaurant]) -> String {
    
    var wantedRequest = MKLocalSearch.Request()
    
    wantedRequest.naturalLanguageQuery = "Restaurant"
    
    wantedRequest.region = theRegion
    
    var wantedSearch = MKLocalSearch(request: wantedRequest)
    
    //wantedSearch.start(completionHandler: )
    
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


struct RestaurantsMapView: View {
    
    
    var locationManager = LocationManager()
    
    /** Sti yrkeshögskolan = 59.310230470905275, 18.021426935241518 */
    
    @State var cookingChefsPersons : [Restaurant] = []
    
    @State var mapConfiguration = MKStandardMapConfiguration()
    
    @State var showAlert: Bool = false
    
    @EnvironmentObject var db: DbConnection
    
    @Binding var viewThemOnMap: Bool
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.30769909740655, longitude: 18.030594636663807), span: MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010))
    
    @State var selectedRestaurant: Restaurant?
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack (alignment: .leading) {
                
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.none),  annotationItems: db.localAndGlobalRestaurantsList) {
                    restaurant in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.location.latitude, longitude: restaurant.location.longitude), content: {
                        
                        Button(action: {
                            selectedRestaurant = restaurant
                        }, label: {
                                                        
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
                            
                            ZStack {
                                
                                HStack {
                                    
                                    ZStack {
                                        
                                        Circle().fill(Color.gray).frame(width: 30, height: 30, alignment: .center)
                                        
                                        Image(systemName: "fork.knife.circle").resizable().foregroundColor(Color.red).frame(width: 26, height: 26, alignment: .center)
                                    }
                                    
                                    Text(restaurant.name)

                                }
                                
                            }
                            
                        }
                               
                            )
                    }
                        )
                    
                }.ignoresSafeArea().onTapGesture {
                    
                    selectedRestaurant = nil
                    
                }.overlay(alignment: .bottom, content: {
                    
                    VStack  {
                        
                        if let selectedRestaurant = selectedRestaurant {
                            
                            NavigationLink(destination: RestaurantView(restaurant:                selectedRestaurant), label: {
                                
                                /// TODO : Add button that sets selectedRestaurant only around the round circle with text underneath
                                Label("More details", systemImage: "bolt.fill")
                                /*
                                 RestaurantDetailView(restaurant: selectedRestaurant).padding()
                                 */
                            }).background(Color.yellow)
                        }
                        
                        Button(action: {
                            
                            var look157 = populateRestarantsNearByPlaces(theRegion: region, theCookingChefs: cookingChefsPersons)
                            print(look157)
                            
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: /* theRestaurantStations.first?.location.latitude ?? */ 59.31467147477161, longitude: /* theRestaurantStations.first?.location.longitude ?? */ 18.01789740387893 )  , content: {
                                
                                Circle().fill(.red).frame(width: 65, height: 65, alignment: .center )
                                
                                Text("Jesus").bold().font(.title).padding()
                                
                            } )
                        }, label: {
                            
                            Text(" Major resturants in the world ").bold().background(.yellow).cornerRadius(9)
                            
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
                
               Text("⬇️ The under-map is for other yummies globally ⬇️")
                
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: theRestaurantStations) { myRestaurantStation in
                    
                    MapPin(coordinate: CLLocationCoordinate2D(latitude: myRestaurantStation.location.latitude, longitude: myRestaurantStation.location.longitude), tint: .red)
                    
                }
                
            }.padding().background(.orange)
            
        }.background(.yellow)
    }
}

#Preview {
    
    RestaurantsMapView( viewThemOnMap: .constant(true)).environmentObject(DbConnection())
//    RestaurantsMapView(db: , viewThemOnMap: .constant(true))
//    RestaurantsMapView(db: DbConnection(), viewOnMap: .constant(true)).environmentObject(DatabaseConnection())
    
}
