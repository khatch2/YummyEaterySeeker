//
//  TryFirstHere.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-11.
//

import SwiftUI
import Foundation
import MapKit

var regionHere = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.30769909740655, longitude: 18.030594636663807), span: MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010))

//var countyHereApi: String = "N/A"



/// My actual HERE API key
let apiKey = "mo39AlmMSwOj7GzZepnO9u_wk0xhgRB2rUYiXtuCdUk"

struct ShowMapFromAddressHereDotCom: View {
    
    @State var countyHereApi: String = "N/A"
    
    @State private var address: String = ""
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.31048924252773, longitude: 18.022006047163448),
           span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
       )

    @State private var annotation = MKPointAnnotation()


    
//    @State private var txtAddress: String = ""
//    
//    @State private var regionHereBinding: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: regionHere.self.center.latitude, longitude: regionHere.self.center.longitude), span: regionHere.self.span)
//    
//    @State private var region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) )
//    
//    @State private var annotation = MKPointAnnotation()

    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView {
                
                VStack {
                    
                    TextField("Enter address", text: $address, onCommit: {
                                    // Geocode the entered address and update the map
                                    updateMapForAddress()
                                })
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    VStack {
                        
                        Text(" County: ")
                        
                        Text(countyHereApi)
                        
                        Button(action: {
                            geocodeAddress(address: $address.wrappedValue , apiKey: apiKey)
                        
                                            }, label: {
                        
                                                Text("Show County by Here.com api").bold().padding().background(.mint).foregroundColor(.blue).cornerRadius(9)
                        
                                            })

                        
                    }.background(.gray).cornerRadius(9).padding()
                    
                    
                    Button(action: {
                        
//                        Map().frame(width: 200, height: 200, alignment: .center)
                        
                        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: [annotation]) { place in
                                        MapPin(coordinate: place.coordinate, tint: .red)
                                    }.mapStyle(.imagery(elevation: .realistic))
                                    /* .mapType(.satellite) // Set the map type to satellite */
                        
                        
                    }, label: {
                        Text(" Red map-pin ").background(.yellow).cornerRadius(9).padding()
                    })

                    Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: [annotation]) { place in
                        
                                    MapPin(coordinate: place.coordinate, tint: .red)
                    }.mapStyle(.hybrid(elevation: .automatic, pointsOfInterest: PointOfInterestCategories.including([MKPointOfInterestCategory.restaurant]), showsTraffic: true))
                                /* .mapType(.satellite) // Set the map type to satellite */
                    .frame(width: 250, height: 250, alignment: .center)
                    
//                    Text("Hello, ShowMapFromAddressHereDotCom")
                    
//                    Text("Write down any real textual address?")
                    
                    /// Min yrkeshögskolan nu, eller hur?
//                    TextField("Liljeholmstorget 7, Stockholm", text: $txtAddress, onCommit: {
//                        
//                        /// Geocode the entered address and update the map
//                        updateMapForAddress()
//                        
//                    } ).textFieldStyle(RoundedBorderTextFieldStyle())
//                        .font(.custom("times", size: 14))
//                        .keyboardType(.default)
//                        .textInputAutocapitalization(.never)
//                        .padding()
                    
//                    Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: [annotation]) { place in
//                        
//                                    MapPin(coordinate: place.coordinate, tint: .red)
//                        
//                    }.mapStyle(.imagery(elevation: .realistic)) /// Set the map type to satellite
                    
            
//                    Button(action: {
//                        
//                        geocodeAddress(address: $txtAddress.wrappedValue , apiKey: apiKey)
//
//                    }, label: {
//                        
//                        Text("Show it on Map by Here.com api").bold().padding().background(.mint).foregroundColor(.blue).cornerRadius(9)
//
//                    })
                                        
                    /// _____
                    ///  ____
                    
                }.background(.orange).cornerRadius(9).padding()
                
            }.background(.yellow)

        }
        
    }
    
    private func updateMapForAddress() {
        
            let geocoder = CLGeocoder()
        
            geocoder.geocodeAddressString(address) { placemarks, error in
                
                if let placemark = placemarks?.first, let location = placemark.location {
                    // Update the region and annotation for the entered address
                    region.center = location.coordinate
                    annotation.coordinate = location.coordinate
                    annotation.title = self.address
                    
                } else {
                    // Handle error or provide feedback to the user
                    print("Location not found for the entered address.")
                }
            }
        }
    
    func geocodeAddress(address: String, apiKey: String) -> String {
        
        /// Construct the URL for the Geocoding API
        let baseUrl = "https://geocode.search.hereapi.com/v1/geocode"
        
        let queryItems = [
            URLQueryItem(name: "q", value: address),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            
            print("Invalid URL")
            
            return "Invalid URL"
        }
        
        /// Make the request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                
                print("Error: \(error.localizedDescription)")
                
                return
            }
            
            guard let data = data else {
                
                print("No data received")
                
                return
            }
            
            do {
                /// Parse the JSON response
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let responseDict = json as? [String: Any],
                   let items = responseDict["items"] as? [[String: Any]] {
                    for item in items {
                        
                        print()
                        print(" type(of: items)   ", type(of: items))
                        print(" items =   ", items)
                        print()
                        
                        print()
                        print("type(of: item)   ", type(of: item))
                        
    //                    let resultAddress = item["address"]
                        
                        guard let resultAddress = item["address"] as? [String: Any], let resultCounty = resultAddress["county"] as? String, resultCounty.count > 1 else {return}
                        
                        print(type(of: resultCounty))
                        
                        print(resultCounty)
                        
                        countyHereApi = resultCounty
                        
    //                    var resultCounty = resultAddress["county"] as? String
                        
    //                    print(" item =   ", resultCounty ?? "defaultValue")
                        print()
                        
                        
                        if let title = item["title"] as? String,
                           let position = item["position"] as? [String: Double] {
                            
                            let latitude = position["lat"] ?? 0.0
                            
                            let longitude = position["lng"] ?? 0.0
                            
                            /// @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.30769909740655, longitude: 18.030594636663807), span: MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010))

                            
                            print("Title: \(title), Latitude: \(latitude), Longitude: \(longitude)")
                            
                            regionHere = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                            
                            print("regionHere <> ", type(of: regionHere), " <> ", regionHere)

                        }
                    }
                }
            } catch {
                
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            
        }.resume()
        
        print(countyHereApi)
        
        return countyHereApi
    }


}

/// Make MKPointAnnotation conform to Identifiable
extension MKPointAnnotation: Identifiable {
    public var id: String? { title }
}

#Preview {
    
    ShowMapFromAddressHereDotCom()
    
}
