//
//  AddRestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-27.
//

import SwiftUI
import FirebaseFirestore

struct AddRestaurantView: View {
    
    var db: Firestore?
    
    @State var restaurantName = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Lägg till en restaurang").padding()
                    
                    TextField("Ange restaurangens namn", text: $restaurantName).textFieldStyle(.roundedBorder).padding()
                    
                    Button(action: {
                        
                        if !restaurantName.isEmpty {
                            
                            let newRestaurant = Restaurant(name: restaurantName, isActive: true)
                            
                            if let db = db {
                                do {
                                    
                                    let doc = try db.collection("restaurants").addDocument(from: newRestaurant)
                                    
                                    print("Created document with id: \(doc.documentID)")
                                    
                                } catch let error {
                                    print(error.localizedDescription)
                                }

                                //db.collection("restaurants").document("ahmad").setData(["name": restaurantName])
                            }
                            
                            
                        }
                        

                        
                    }, label: {
                        Text("Skapa").bold()
                    })
                }.background(Color.orange).padding()
            }.background(Color.yellow).padding()
        }
        
        
    }
    
}


#Preview {
    AddRestaurantView()
}


