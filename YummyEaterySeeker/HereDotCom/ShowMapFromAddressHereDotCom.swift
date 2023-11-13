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


func geocodeAddress(address: String, apiKey: String) {
    
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
        
        return
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
                    print(" item =   ", item)
                    print()
                    
                    
                    if let title = item["title"] as? String,
                       let position = item["position"] as? [String: Double] {
                        
                        let latitude = position["lat"] ?? 0.0
                        
                        let longitude = position["lng"] ?? 0.0
                        
                        /// @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.30769909740655, longitude: 18.030594636663807), span: MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010))

                        
                        print("Title: \(title), Latitude: \(latitude), Longitude: \(longitude)")
                        
                        regionHere = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

                    }
                }
            }
        } catch {
            
            print("Error parsing JSON: \(error.localizedDescription)")
        }
        
    }.resume()
}

/// My actual HERE API key
let apiKey = "mo39AlmMSwOj7GzZepnO9u_wk0xhgRB2rUYiXtuCdUk"

struct ShowMapFromAddressHereDotCom: View {
    
    @State var txtAddress = ""
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                Text("Hello, ShowMapFromAddressHereDotCom")
                
                Text("Write down any real textual address?")

                TextField("Tjädervägen 11 , Tyresö", text: $txtAddress)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("times", size: 14))
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                    .padding()

                
                Button(action: {
                    
                    /// Min äldsta kvinnliga klasskamrat, eller hur?
                    geocodeAddress(address: "Tjädervägen 11 , Tyresö", apiKey: apiKey)

                    
                }, label: {
                    
                    Text("Show it on Map by Here.com api").bold().padding().background(.mint).foregroundColor(.blue).cornerRadius(9)

                })
                
            }.background(.orange).padding()
            
        }.background(.yellow)
        
        
    }
    
}

#Preview {
    
    ShowMapFromAddressHereDotCom()
    
}
