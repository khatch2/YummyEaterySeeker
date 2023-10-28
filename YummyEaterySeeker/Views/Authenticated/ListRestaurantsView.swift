//
//  ListRestaurantsView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//


import Foundation
import SwiftUI


struct ListRestaurantsView: View {
    
    @ObservedObject var db: DbConnection
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Text(" Restaurangs / Yummies ").font(.custom("times", size: 28)).bold().padding()
                
                if let userData = db.currentUserData {
                    
                    if userData.restaurants.count < 1 {
                        Text("No restaurants yet!")
                    } else {
                        List() {
                            ForEach(userData.restaurants) { restaurant in
                                Text(restaurant.name)
                            }
                        }
                    }

                } else {
                    
                    Text("Unexpected error, please contact your administrator.")
                        .font(.custom("times", size: 20))
                    
                }
            
                NavigationLink(destination: AddRestaurantView(db: db), label: {
                    
                    Text(" Add a new Yummy? ")
                        .bold()
                        .font(.custom("times", size: 24))
                        .padding()
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(15)
                }).background(Color.cyan)
            }.background(Color.orange)
        }.background(Color.yellow)
    }
}

#Preview {
    ListRestaurantsView(db: DbConnection())
}
