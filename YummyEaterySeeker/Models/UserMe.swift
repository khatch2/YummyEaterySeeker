//
//  User.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import Foundation

struct UserMe: Codable, Identifiable {
    
//    var id: String
//    @DocumentID var id: String?
    var id = UUID() /* String */
    
    var name: String
    
    var email: String
    
    var joinedTime: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case joinedTime = "joined_time"
    }
    
    init(id: UUID = UUID(), name: String, email: String, joinedTime: TimeInterval) {
        self.id = id
        self.name = name
        self.email = email
        self.joinedTime = joinedTime
    }
    
}
