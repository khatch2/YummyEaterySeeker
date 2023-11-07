//
//  ContentView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var db: DbConnection
        
    var body: some View {
        
        if db.userHasLoggedIn {
            NavigationStack {
                RestaurantsListView(db: _db)
            }
        } else {
            NavigationStack {
                LoginView(txtError: .constant("Library"))
            }
        }
    }
}

#Preview {
    ContentView()
}
