//
//  ContentView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-27.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    @State var dbFirestore = Firestore.firestore()
    
    @State var restaurantName = ""
    
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
            
            Text("Add a new restaurant").padding()
            
            TextField("Enter the name of a restaurant?", text: $restaurantName).textFieldStyle(.roundedBorder).padding()
            
            Button(action: {
                if (!restaurantName.isEmpty) {
                    
                    var newRestaurant = Restaurant(name: restaurantName, isActive: true)
                    
                    var againRestaurant = Restaurant(name: "tryRestaurant2", isActive: true)
                    
                    dbFirestore.collection("Created_Restaurants").document("New_Restaurant").setData(["name": restaurantName])
                    
                    
                    dbFirestore.collection("test2").document("david").setData(["Ulvan": "Student"])
                    
                    do {
                        let doc = try dbFirestore.collection("Created_Restaurants").addDocument(from: againRestaurant)
                        
                        print(" doc.documentID ", doc.documentID)
                        
                        print(type(of: dbFirestore))

                } catch let error {        print(error.localizedDescription)    }

                } }, label: {
                Text("Create an entry in Firestore")
            })
        }
        .padding()
    }
}

//struct AddRestaurantView: View {
//    
//    var db: Firestore
//    
//    @State var restaurantName = ""
//    
//    var body: some View {
//        VStack {
//            Text("Lägg till en restaurang").padding()
//            
//            TextField("Ange restaurangens namn", text: $restaurantName).textFieldStyle(.roundedBorder).padding()
//            
//            Button(action: {
//                
//                if !restaurantName.isEmpty {
//                    
//                    let newRestaurant = Restaurant(name: restaurantName, isActive: true)
//                    
//                    do {
//                        
//                        let doc = try db.collection("restaurants").addDocument(from: newRestaurant)
//                        
//                        print("Created document with id: \(doc.documentID)")
//                        
//                    } catch let error {
//                        print(error.localizedDescription)
//                    }
//
//                    //db.collection("restaurants").document("ahmad").setData(["name": restaurantName])
//                }
//                
//
//                
//            }, label: {
//                Text("Skapa").bold()
//            })
//        }
//        .padding()
//    }
//    
//}


#Preview {
    ContentView()
}
