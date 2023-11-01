//
//  Restaurant.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//


import Foundation
import FirebaseFirestoreSwift

struct Restaurant: Codable, Identifiable {
    
    var id = UUID()
    
    var name: String
    
    var category = "restaurant"
    
    var isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case id
        
        case name
        
        case category
        
        case isActive = "is_active"
    }
}

/* From the teacher, begin */

// Sti coordinates: 59,30972667974045, 18,021641515542505

struct RestaurantExample {
    
    var id: String
    var name: String
    var description: String
    var openingHours: String
    var location: Location
    var reviews: [Review]
    var rating: Double
    var image: String
}

struct Review {
    
    var userName: String
    var message: String
    var rating: Double
    
}

struct Location {
    
    var latitude: Double
    var longitude: Double
    
}
/* From the teacher, end */
