//
//  UserData.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

//import SwiftUI
//
//struct UserData: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import Foundation
import FirebaseFirestoreSwift

struct UserData: Codable {
    
    @DocumentID var id: String?
    var restaurants: [Restaurant]
    var birthdate: Date
    
}

//#Preview {
//    UserData()
//}
