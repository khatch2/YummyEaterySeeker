//
//  Restaurant.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import Foundation

struct Restaurant : Codable, Identifiable {
    
    var description: String
    
    var id: String
    
    var image: String

    var location: [Location]
    
    var name: String
    
    var openingHours: String

    var rating: Int
    
    var reviews: [Review]
    
}

struct Location: Codable /* , Identifiable */ {
    
//    var id = UUID()
    var latitude: Double
    var longitude: Double
    
}


/* From the teacher, begin */

// Sti coordinates: 59,30972667974045, 18,021641515542505

//struct RestaurantExample {
//
//    var id: String
//    var name: String
//    var description: String
//    var openingHours: String
//    var location: Location
//    var reviews: [Review]
//    var rating: Double
//    var image: String
//}


//struct Review: Codable /* , Identifiable */ {
//    
////    var id = UUID()
//    var userName: String
//    var message: String
//    var rating: Double
//    
//}




/* From the teacher, end */
