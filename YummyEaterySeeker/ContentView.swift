//
//  ContentView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {

    @StateObject var db = DbConnection()
    
    @State var restaurants = [Restaurant]()
    
    var body: some View {

        if let user = db.currentUser {
            
            NavigationStack {
                
                ListRestaurantsView(db: db)
            }
            
        } else {
            
            NavigationStack {
                
                LoginView(db: db)
            }
        }
    }
}



#Preview {
    ContentView()
}
