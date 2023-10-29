//
//  CookingChef.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-29.
//

import Foundation

import CoreLocation

struct CookingChef: Identifiable {
    
    var id = UUID()
    var name: String
    
    var latitude: Double
    var longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
