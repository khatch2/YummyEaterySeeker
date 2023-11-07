//
//  RestaurantsListView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI
import Firebase

//func copyDocument(from sourceCollection: String, sourceDocument: String, to targetCollection: String, targetDocument: String) {
//    let sourceRef = Firestore.firestore().collection(sourceCollection).document(sourceDocument)
//    let targetRef = Firestore.firestore().collection(targetCollection).document(targetDocument)
//
//    sourceRef.getDocument { (document, error) in
//        if let error = error {
//            print("Error fetching source document: \(error.localizedDescription)")
//        } else if let document = document, document.exists {
//            targetRef.setData(document.data() ?? [:]) { error in
//                if let error = error {
//                    print("Error copying document: \(error.localizedDescription)")
//                } else {
//                    print("Document copied successfully.")
//                }
//            }
//        } else {
//            print("Source document does not exist.")
//        }
//    }
//}

struct RestaurantsListView: View {
    
    @EnvironmentObject var db: DbConnection
        
    @State var restaurants = [Restaurant]()
    
    @State var viewItOnTheMap = false
    
    var body: some View {
        
        // Authenticated NavigationStack
        NavigationStack {
            
                    GeometryReader { geometry in
                        
                        ZStack(alignment: .leading) {
                    
                    ScrollView {
                        
                        if let userData = db.currentUser {
                            
                            Text("userData \(userData)")
                            
                        }
                        
                        Text("Restaurants").bold().font(.title)
                        
                        Spacer()
                        
                        ForEach(db.restaurantsList) { restaurant in
                            
                            NavigationLink(destination: RestaurantView(restaurant: restaurant), label: {
                                    RestaurantDetailView(restaurant: restaurant)
                            }
                            )
                        }
                        
                    }.overlay(alignment: .bottom,
                              content: {
                        
                        Button(action: {
                            
                            viewItOnTheMap.toggle()
                            
                        }, label: {
                            
                            Text("View them on map").padding().background(.orange).foregroundColor(.blue).cornerRadius(9)
                        })
                        
                    })
                    
                    if viewItOnTheMap {
                        
                        RestaurantsMapView(viewThemOnMap: $viewItOnTheMap)
                        
//                        RestaurantsMapView(db: DbConnection(), viewThemOnMap: $viewItOnTheMap).environmentObject(DbConnection())
                        
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    RestaurantsListView()
}
