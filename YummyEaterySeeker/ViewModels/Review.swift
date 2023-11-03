//
//  Review.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import Foundation

struct Review: Codable, Identifiable {
    
    var id: String
    
    var name: String
    
    var message: String
    
}
