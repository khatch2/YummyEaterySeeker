//
//  AddRestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

//import SwiftUI
//
//struct AddRestaurantView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import Foundation
import SwiftUI
import FirebaseFirestore

struct AddRestaurantView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var db: DbConnection
    
    @State var restaurantName = ""
    
    var body: some View {
        VStack {
            Text("Lägg till en restaurang").padding()
            
            TextField("Ange restaurangens namn", text: $restaurantName).textFieldStyle(.roundedBorder).padding()
            
            Button(action: {
                
                if !restaurantName.isEmpty {
                    
                    let newRestaurant = Restaurant(name: restaurantName, isActive: true)

                    db.addRestaurantToDb(restaurant: newRestaurant)
                    dismiss()
                }
                

                
            }, label: {
                Text("Skapa").bold()
            })
        }
        .padding()
    }
    
}

//struct AddRestaurantView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRestaurantView(db: DbConnection() )
//    }
//}

#Preview {
    AddRestaurantView(db: DbConnection())
}
