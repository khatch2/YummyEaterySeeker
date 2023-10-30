//
//  WantedRestaurants.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-29.
//

import Foundation
import MapKit
import SwiftUI


/**
 TODO : 
 
 En app där man kan skapa konto och logga in. Man kan se restauranger antingen i en lista eller i en kartvy. Man kan klicka på en restaurang, och läsa mer om den. Man kan se andra användare's reviews och rating över appen, och själv lämna en review
 
 An app where you can create an account and log in. You can see restaurants either in a list or in a map view. You can click on a restaurant and read more about it. You can see other users' reviews and ratings of the app, and leave a review yourself
 
 */

var myDesiredRestaurants : [MKPointOfInterestCategory] = [.restaurant]

var theRestaurantStations: [RestaurantStation] = [RestaurantStation(name: "Chamsin Grill - Libanesisk Restaurang Stockholm", latitude: 59.31303080041355, longitude: 18.027991342255227)]


func populateNearByPlaces(theRegion: MKCoordinateRegion, theCookingChefs: [CookingChef]) -> String {
    
//    var theRestaurantStations: [RestaurantStation] = [RestaurantStation(name: "Chamsin Grill - Libanesisk Restaurang Stockholm", latitude: 59.31303080041355, longitude: 18.027991342255227)]
    
    var wantedRequest = MKLocalSearch.Request()
    
    wantedRequest.naturalLanguageQuery = "Restaurant"
    
    wantedRequest.region = theRegion
    
    print()
//    print("wantedRequest = " , wantedRequest)
    print()
    
    var wantedSearch = MKLocalSearch(request: wantedRequest)
    
    print()
//    print("wantedSearch = " , wantedSearch)
    print()
    
    wantedSearch.start() { (response, error) in
        
        guard let response = response else {return}
        
        print("response is = ", response.self.mapItems.first?.url ?? "N/A")
        
        print("error = ", error)
        
        for item in response.mapItems {
            
            print()
            print(" item.placemark = ", item.placemark)
            print("typeof item is: ", type(of: item))
            
            print(" theRestaurantStations.count = ", theRestaurantStations.count)
           
//            theRestaurantStations.append(RestaurantStation(name: item.name ?? "default value", latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude))
            
            theRestaurantStations.append(RestaurantStation(name: item.name ?? "N/A", phoneNumber: item.phoneNumber, placemark: item.placemark, timeZone: item.timeZone, url: item.url, latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude))
            
            print("theRestaurantStations.count = " , theRestaurantStations.count)
            
            print("<><><><><><><>")
            
            var look2 = MapMarker(coordinate: item.placemark.coordinate)
            print("typof look2 is: ", type(of: look2))
            print(" look2 = ", look2)
            
            MapMarker(coordinate: item.placemark.coordinate)
            
            
            
        }
        
        print(" theRestaurantStations = ", theRestaurantStations)
    }
    
    return "Done"
}


struct WantedRestaurants: View {
    
    var locationManager = LocationManager()
    
    /* Sti yrkeshögskolan = 59.310230470905275, 18.021426935241518 */
        @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.310230470905275, longitude: 18.021426935241518), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
    
    @State var cookingChefsPersons = [
        CookingChef(name: "Try1_CookingChef", latitude: 59.30988051077419, longitude: 18.021906254160758),
        CookingChef(name: "try2_CookingChef", latitude: 59.30551000, longitude: 18.00936000)]
    
    @State var mapConfiguration = MKStandardMapConfiguration()
    
    
    
    var body: some View {
        
        Text("Restaurants' Finder").bold().padding()
        
        Button(action: {
            
            
            var look93 = populateNearByPlaces(theRegion: region, theCookingChefs: cookingChefsPersons)
                        
            
        }, label: {
            Text("Seek eatries now").bold().background(Color.yellow)
        })
        
        // DONE : Change it from cookingChefsPersons to theRestaurantStations
        
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: theRestaurantStations) { myRestarantsStation in
            
        
            MapAnnotation(coordinate: myRestarantsStation.coordinates, content: {
                VStack {
                    
                    ZStack {
                        Circle().fill(.gray).frame(width: 40, height: 40, alignment: .center)
                        Image(systemName: "fork.knife.circle")
                    }
                    
                    VStack {
                        
                        Text(myRestarantsStation.name )
                            .font(.title).foregroundStyle(.red)
                        + Text("\n") + Text(myRestarantsStation.phoneNumber ?? "N/A").font(.title2).foregroundStyle(.green)
                        + Text("\n") +  Text(myRestarantsStation.url?.absoluteString ?? "N/A").font(.title3).foregroundStyle(.blue)
                        
//                        Text(myRestarantsStation.phoneNumber ?? "N/A").padding().foregroundColor(.green).background(Color.white).cornerRadius(9)


//                        Text(myRestarantsStation.url?.absoluteString ?? "N/A").padding().foregroundColor(.blue).background(Color.white).cornerRadius(9)
                        
                    }.background(.white)
                    
                    
                    
//                    Label("Lightning", systemImage: "bolt" )
                    
                }
            }
        )
        }.ignoresSafeArea()
        
        VStack {
            
//            Spacer()
            
            Button(action: {
                locationManager.askPermission()
            }, label: {
                Text("Get my location").bold().padding().foregroundColor(.white).background(.black).cornerRadius(9)
            })
            
        }

        
}
}

#Preview {
    WantedRestaurants()
}
