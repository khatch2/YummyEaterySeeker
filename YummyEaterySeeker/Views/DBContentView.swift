//
//  DbContentView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-29.
//

import SwiftUI
import FirebaseFirestore


struct DBContentView: View {
    
    @StateObject var db = DbConnection()
    
    @State var restaurants = [Restaurant]()
    
    var body: some View {
        
        if let user = db.currentUser {
            
            // Authenticated
            NavigationStack {
                ListRestaurantsView(db: db)
            }
            
            // Unauthenticated
        } else {
            NavigationStack {
                LoginView(db: db)
            }
        }
    }
}


#Preview {
    DBContentView()
}
