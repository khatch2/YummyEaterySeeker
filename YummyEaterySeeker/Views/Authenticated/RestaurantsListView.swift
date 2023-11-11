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
        
//    @State var restaurants = [Restaurant]()
    
    @State var viewItOnTheMap = false
    
    var body: some View {
        
        /// Authenticated NavigationStack
        NavigationStack {
            
                    GeometryReader { geometry in
                        
                        VStack(alignment: .leading) {
                    
                    if viewItOnTheMap {
                        
                        RestaurantsMapView(viewThemOnMap: $viewItOnTheMap)
                        
                    } else {
                        
                        ScrollView(.vertical) {
                                                        
                            Text("Restaurants").bold().font(.title)
                            
                            ForEach(db.restaurantsList) { restaurant in
                                
                                HStack {
                                                                        
                                    Image(systemName: "fork.knife.circle").resizable().foregroundColor(.red).background(.regularMaterial).frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.5, alignment: .center)
                                        
                                    NavigationLink(destination: RestaurantView(restaurant: restaurant), label: {
                                        
                                            RestaurantDetailView(restaurant: restaurant)
                                        
                                    } )
                                    
                                }
                                
                            }
                            
                        }.overlay(alignment: .bottom,
                                  content: {
                            
                            Button(action: {
                                
                                viewItOnTheMap.toggle()
                                
                            }, label: {
                                
                                Text("View them on map")
                                    .bold().padding().background(.mint).foregroundColor(.blue).cornerRadius(9)
                            })
                            
                        }).position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
                        
                    }
                    
                }.background(.orange)
            }
        }
    }
}

#Preview {
    
    RestaurantsListView()
    
}
