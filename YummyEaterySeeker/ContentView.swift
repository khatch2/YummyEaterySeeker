//
//  ContentView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-27.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    var dbFirestore = Firestore.firestore()
    
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
                    dbFirestore.collection("Created_Restaurants").document("New_Restaurant").setData(["name": restaurantName])
                }
//                dbFirestore.collection("test1").addDocument(data: ["name": "Tony Tomas"])
                dbFirestore.collection("test2").document("david").setData(["Ulvan": "Student"])
            }, label: {
                Text("Create an entry in Firestore")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
