//
//  AddRestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//


import Foundation
import SwiftUI
import FirebaseFirestore

struct AddRestaurantView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var db: DbConnection
    
    @State var restaurantName = ""
    
    // Debug purpose only, then comment the following line:
    @State var restaurantImage = "https://www.svtstatic.se/image/wide/992/41404046/1697528910"
    
    var body: some View {
        VStack {
            Text(" Add a new restaurant into database? ")
                .background(Color.yellow)
                .font(.custom("times", size: 20))
                .padding()
            
            TextField(" Enter the name of the restaurant? ", text: $restaurantName)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 16, design: .serif))
                .padding()
            
            Button(action: {
                
                if !restaurantName.isEmpty {
                                        
                    let newRestaurant = Restaurant( image: restaurantImage, name: restaurantName)

                    db.addRestaurantToDb(restaurant: newRestaurant)
                    
                    dismiss()
                }
            }, label: {
                
                Text(" Add it into DB")
                    .bold()
                    .font(.custom("Chalkduster", size: 18))
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(19.0)
            })
        }.background(Color.orange).padding()
    }
}

#Preview {
    AddRestaurantView(db: DbConnection())
}
