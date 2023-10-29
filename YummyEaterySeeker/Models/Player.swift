//
//  Player.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-29.
//

import Foundation
import FirebaseFirestoreSwift

struct Player: Codable, Identifiable {
    
    //    @DocumentID var id: String?
    var id = UUID()
    var name: String
    var category = "player"
    var isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id  // PERHAPS, Comment me to avoid a bug
        case name
        case category
        case isActive = "is_active"
    }
    
    init(id: UUID = UUID(), name: String, category: String = "player", isActive: Bool) {
        self.id = id
        self.name = name
        self.category = category
        self.isActive = isActive
    }
    
}

