//
//  UserData.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import Foundation
import FirebaseFirestoreSwift

struct UserData: Codable {
    
    @DocumentID var id: String?
    
    var restaurants: [Restaurant]
    
    var birthdate: Date
    
    var image: String
    
}

