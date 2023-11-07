//
//  ContentView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import SwiftUI
//import FirebaseFirestore

struct ContentView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection    
    @StateObject var db = DbConnection()
    
    var body: some View {

        if dbConnection.userLoggedIn {
            NavigationStack {
                RestaurantsListView(db: db)
            }
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}



#Preview {
    ContentView()
}
