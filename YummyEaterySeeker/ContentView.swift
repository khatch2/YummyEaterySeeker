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
    
    var body: some View {

        if dbConnection.userLoggedIn {
            NavigationStack {
                RestaurantsListView()
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
