//
//  RestaurantStation.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-29.
//

import Foundation

import CoreLocation

struct RestaurantStation: Identifiable {
    
    var id = UUID()
    var name: String
    
    var phoneNumber: String?
    var placemark: String?
    var timeZone: String?
    var url: String?
    
    var latitude: Double
    var longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
