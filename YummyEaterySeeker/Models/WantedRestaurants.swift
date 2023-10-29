//
//  WantedRestaurants.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-29.
//

import Foundation
import MapKit

import SwiftUI


var myDesiredRestaurants : [MKPointOfInterestCategory] = [.restaurant]

func populateNearByPlaces(theRegion: MKCoordinateRegion, theCookingChefs: [CookingChef]) -> String {
    
    var theRestaurantStations: [RestaurantStation] = [RestaurantStation(name: "Chamsin Grill - Libanesisk Restaurang Stockholm", latitude: 59.31303080041355, longitude: 18.027991342255227)]
    
    var wantedRequest = MKLocalSearch.Request()
    
    wantedRequest.naturalLanguageQuery = "Restaurant"
    
    wantedRequest.region = theRegion
    
    print()
    print("wantedRequest = " , wantedRequest)
    print()
    
    var wantedSearch = MKLocalSearch(request: wantedRequest)
    
    print()
    print("wantedSearch = " , wantedSearch)
    print()
    
    wantedSearch.start() { (response, error) in
        
        guard let response = response else {return}
        
        for item in response.mapItems {
            
            print(" item = ", item.placemark.coordinate.latitude)
            print("typeof item is: ", type(of: item))
            
            print(" theRestaurantStations.count = ", theRestaurantStations.count)
            theRestaurantStations.append(RestaurantStation(name: item.name ?? "default value", latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude))
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
    
    var location = LocationManager()
    
    /* Sti yrkeshögskolan = 59.310230470905275, 18.021426935241518 */
        @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.310230470905275, longitude: 18.021426935241518), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
    
    @State var cookingChefsPersons = [
        CookingChef(name: "Try1_CookingChef", latitude: 59.30988051077419, longitude: 18.021906254160758),
        CookingChef(name: "try2_CookingChef", latitude: 59.30551000, longitude: 18.00936000)]
    
    @State var mapConfiguration = MKStandardMapConfiguration()
    
    
    
    var body: some View {
        
        Text("Restaurants' Finder").bold().padding()
        
        Button(action: {
            print("myDesiredRestaurants.first?.rawValue", myDesiredRestaurants.first?.rawValue)
        }, label: {
            Text("myButton").bold().background(Color.yellow)
        })
        
        // TODO : Fix the following peice of code?
        
//        Map(coordinateRegion: $region, annotationItems: $cookingChefsPersons) { myCookingChef in
//            
//            MapMarker(coordinate: myCookingChef.coordinates)
//            
//        }
        
        
        
    }
    
}

#Preview {
    WantedRestaurants()
}
