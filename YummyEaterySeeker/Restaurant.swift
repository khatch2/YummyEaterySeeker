//
//  Restaurant.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-27.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Restaurant: Codable {
    
    @DocumentID var id: String?
    var name: String
    var category = "restaurant"
    var isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case category
        case isActive = "is_active"
    }
    
    }


