//
//  ListRestaurantsView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//


import Foundation
import SwiftUI
import Firebase
//import FirebaseSwiftUI

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


struct ListRestaurantsView: View {
    
    @ObservedObject var db: DbConnection
    
    var body: some View {
        
        // Authenticated NavigationStack
        NavigationStack {
            GeometryReader { geometry in
                
                VStack {
                    
                    VStack {
                        
                        Text(" Restaurangs / Yummies ").font(.custom("times", size: 28)).bold().padding()
                        
                        if let userData = db.currentUserData {
                            
                            if userData.restaurants.count < 1 {
                                
                                Text("No restaurants yet!")
                                
                                // Button kopiera
                                Button(action: {
                                    
                                    copyDocument(from: "restaurants_in_near_liljeholmen", sourceDocument: "55bsCPMGDCcBUF7r9hQU", to: "user_data", targetDocument: "IGvMj2FX7gNMFsLRCu5zhbOBxyW2")
                                    
                                    ListRestaurantsView(db: DbConnection())
                                    
                                }, label: {
                                    Text("Kopiera från Liljeholmen").bold().padding().background(.yellow).cornerRadius(9)
                                })
                                
                                
                            } else {
                                List() {
                                    ForEach(userData.restaurants) { restaurant in
                                        VStack {
                                            HStack {
                                                NavigationLink(destination: ListRestaurantsView(db: DbConnection()), label: {
                                                    Text(restaurant.name)

                                                })
                                            }
                                        }
                                    }
                                }
                                
                                HStack {
                                    
                                    NavigationLink(destination: RegisterView(db: db), label: {
                                        VStack {
                                            HStack {
                                                Text("Goto Registration").bold().padding().background(.yellow).cornerRadius(9)
                                        } }
                                    })
                                    
                                    Button(action: {
                                        do {
                                            try db.auth.signOut()
                                        } catch let signOutError as NSError {
                                            print("Error signing out: %@", signOutError)

                                        }
                                    }, label: {
                                        Text("Log out me").bold().padding().background(.yellow).cornerRadius(9)
                                    })
                                    
                                }
                                
                                HStack {
                                    
                                    NavigationLink(destination: LoginView(db: db), label: {
                                        VStack {
                                            HStack {
                                                Text("Goto Login").bold().padding().background(.yellow).cornerRadius(9)
                                        } }
                                    })
                                    
                                    Button(action: {
                                        
                                        copyDocument(from: "restaurants_in_near_liljeholmen", sourceDocument: "55bsCPMGDCcBUF7r9hQU", to: "user_data", targetDocument: "lhFJXYt0bjVr8v8vRUT13TesWHZ2")
                                        
                                    }, label: {
                                        Text("Copy from Liljeholmen").bold().padding().background(.yellow).cornerRadius(9)
                                    })

                                }
                                

                            }
                            
                        } else {
                            
                            
                            Text("Unexpected error, please contact your administrator.")
                                .font(.custom("times", size: 20))
                            
                            Button(action: {
                                do {
                                    try db.auth.signOut()
                                    
                                } catch let signOutError as NSError {
                                    print("Error signing out: %@", signOutError)

                                }
                            }, label: {
                                Text("Log me out")
                            })
                            
                        }
                        
                        NavigationLink(destination: AddRestaurantView(db: db), label: {
                            
                            Text(" Add a new Yummy/Restaurant? ")
                                .bold()
                                .font(.custom("times", size: 24))
                                .padding()
                                .foregroundColor(.white)
                                .background(.black)
                                .cornerRadius(15)
                        }).background(Color.cyan)
                        
                    }.background(Color.orange)

                    
                }
                
                
            }
            
        }.background(Color.yellow)
    }
}

#Preview {
    ListRestaurantsView(db: DbConnection())
}
