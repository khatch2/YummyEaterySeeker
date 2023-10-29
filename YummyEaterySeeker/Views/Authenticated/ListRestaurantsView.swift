//
//  ListRestaurantsView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//


import Foundation
import SwiftUI


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
                            } else {
                                List() {
                                    ForEach(userData.restaurants) { restaurant in
                                        Text(restaurant.name)
                                    }
                                }
                                
                                NavigationLink(destination: RegisterView(db: db), label: {
                                    VStack {
                                        HStack {
                                            Text("Goto Registration")
                                    } }
                                })
                                
                                Button(action: {
                                    do {
                                        try db.auth.signOut()
                                    } catch let signOutError as NSError {
                                        print("Error signing out: %@", signOutError)

                                    }
                                }, label: {
                                    Text("Log out me")
                                })
                                
                                NavigationLink(destination: LoginView(db: db), label: {
                                    VStack {
                                        HStack {
                                            Text("Goto Login")
                                    } }
                                })
                                
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
