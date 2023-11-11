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
                
                /// Here I used _ as a wrapper instead.
                RestaurantsListView(db: _db)
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
