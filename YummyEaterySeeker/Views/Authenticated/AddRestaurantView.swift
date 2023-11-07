//
//  AddRestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-06.
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
        
        VStack (spacing: 30) {
            
            Text("Add a new restaurant into database?").background(.yellow).font(.custom("times", size: 20))
            
            TextField("Enter the name of the restaurant?", text: $restaurantName).textFieldStyle(.roundedBorder).font(.system(size: 16, design: .serif)).padding()
            
            Button(action: {
                if (!restaurantName.isEmpty) {
                    
                    let newRestaurant = Restaurant(description: "", id: "", image: restaurantImage, location: Location(latitude: 53.234, longitude: 51.3242), name: restaurantName, openingHours: "", rating: 3, reviews: [])
                    
//                    db.addRestaurantToDb(restaurant: newRestaurant)
                    
                    dismiss()
                    
                }
            }, label: {
                Text ("Add it into Db").bold().font(.custom("Chalkduster", size: 18)).padding().background(Color.yellow).cornerRadius(19)
            } )
            
            Text("Hello, AddRestaurantView")
        
        }.background(.orange).padding()
        
    }
}

#Preview {
    AddRestaurantView( db: DbConnection())
}