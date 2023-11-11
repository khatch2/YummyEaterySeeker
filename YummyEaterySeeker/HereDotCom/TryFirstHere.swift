//
//  TryFirstHere.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-11.
//

import SwiftUI
import Foundation

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
    
    // Make the request
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
            // Parse the JSON response
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
                        
                        print("Title: \(title), Latitude: \(latitude), Longitude: \(longitude)")
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

struct TryFirstHere: View {
    
    var body: some View {
        
        Text("Hello, TryFirstHere")
        
        Button(action: {
            
            /// Min äldsta kvinnliga klasskamrat, eller hur?
            geocodeAddress(address: "Tjädervägen 11 , Tyresö", apiKey: apiKey)

            
        }, label: {
            Text("Find my geos?")
        })
    }
}

#Preview {
    TryFirstHere()
}
