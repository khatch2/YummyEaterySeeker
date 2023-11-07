//
//  RestaurantsListView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI
import Firebase

func copyDocument(from sourceCollection: String, sourceDocument: String, to targetCollection: String, targetDocument: String) {
    let sourceRef = Firestore.firestore().collection(sourceCollection).document(sourceDocument)
    let targetRef = Firestore.firestore().collection(targetCollection).document(targetDocument)

    sourceRef.getDocument { (document, error) in
        if let error = error {
            print("Error fetching source document: \(error.localizedDescription)")
        } else if let document = document, document.exists {
            targetRef.setData(document.data() ?? [:]) { error in
                if let error = error {
                    print("Error copying document: \(error.localizedDescription)")
                } else {
                    print("Document copied successfully.")
                }
            }
        } else {
            print("Source document does not exist.")
        }
    }
}


struct RestaurantsListView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @ObservedObject var db: DbConnection
    
    @State var restaurants = [Restaurant]()
    
    @State var viewOnMap = false
    
    var body: some View {
        
//        GeometryReader { geometry in
//            
//            VStack(spacing: 30) {
        
        // Authenticated NavigationStack
        NavigationStack {
                    GeometryReader { geometry in
                        
                
                ZStack {
                    
                    ScrollView {
                        
                        if let userData = db.currentUser {
                            
                            if userData.restaurant.count < 1 {
                                Text("No restaurants yet!!")
                            }
                        }
                        
                        Text("Restaurants").bold().font(.title)
                        
                        Spacer()
                        
                        ForEach(dbConnection.restaurantList) { restaurant in
                            
                            NavigationLink(destination: RestaurantView(restaurant: restaurant), label: {
                                RestaurantVoucher(restaurant: restaurant, isMini: false)
                            })
                        }
                        
                    }.overlay(alignment: .bottom,
                              content: {
                        
                        Button(action: {
                            viewOnMap.toggle()
                            
                        }, label: {
                            
                            Text("View on map").padding().background(.orange).foregroundColor(.purple).cornerRadius(9)
                        })
                        
                    })
                    
                    if viewOnMap {
                        RestaurantsMapView(viewOnMap: $viewOnMap)
                    }
                    
                    VStack (spacing: 30) {
                        
                        Text("Hello, RestaurantsListView")
                        
                        Button(action: {
                                do {
    //                                try db.auth.signOut()
                                    try dbConnection.SignOut()
                                    
                                } catch let signOutError as NSError {
                                    print("Error signing out: %@", signOutError)}
                                                        }, label: {
                                                            
                                                            Text("Log out me").bold().background(.white).cornerRadius(5).padding()
                                                        })

                        
                    }.background(.brown).padding()
                }
            }
        }
    }
}

#Preview {
    RestaurantsListView()
}
