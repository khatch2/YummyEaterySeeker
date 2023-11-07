//
//  UserData.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-06.
//

import Foundation
import FirebaseFirestoreSwift

struct UserData: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var restaurants: [Restaurant]
    
//    var birthdate: Date
    
    var image: String
    
}

