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
