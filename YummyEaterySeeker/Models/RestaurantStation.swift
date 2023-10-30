//
//  RestaurantStation.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-29.
//

import Foundation

import CoreLocation
import MapKit

struct RestaurantStation: Identifiable {
    
    var id = UUID()
    var name: String
    
    var phoneNumber: String?
    var placemark: MKPlacemark?
    var timeZone: TimeZone?
    var url: URL?
    
    var latitude: Double
    var longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

