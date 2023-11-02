//
//  LoginView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import Foundation
import SwiftUI

/*
 
 Each view has a coordinate system. If I have a view with the size 100 with and 100 height, then the coordinate x: 50, y: 50 would correspond to the center point of that view.
 
 When I set .position to a component that is within our view (i.e. child component), I specify the component's center point within the parent view's coordinate system.
 
 */

struct LoginView: View {
    
    @ObservedObject var db: DbConnection
    
    @State var email = ""
    
    @State var password = ""
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .center, spacing: 30) {
            
                Image("restaurant-logo").resizable().frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.28, alignment: .center).padding()
            
            Text("Welcome to Yummy Seeker!")
                .bold()
                .font(.system(size: 24, design: .serif)).italic().padding(.bottom, geometry.size.height * 0.02)
                
                VStack(alignment: .leading) {
                    Text(" Enter your credentials? ").font(.system(size: 20, design: .serif)).bold().italic()
                    
                    TextField("Email address", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .font(.custom("times", size: 14))
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .font(.custom("times", size: 14))
                    
                }.background(Color.orange).padding()
                
                Button(action: {
                    
                    if !email.isEmpty && !password.isEmpty {
                        
                        // Log in the user
                        var look2 = ListRestaurantsView(db: DbConnection())
                        
                        print("look2 = " , look2.db.USER_DATA_COLLECTION.description)
                    }
                    
                }, label: {
                    Text("Log in")
                        .bold()
                        .padding()
                        .foregroundColor(.blue)
                        .background(.yellow)
                        .cornerRadius(9)
                })
                
                Button(action: {
                    do {
                        
                        try db.auth.signOut()
                        
                    } catch let signOutError as NSError {
                        
                        print(" Error signing out: %@ ", signOutError)
                    }
                    
                }, label: {
                    Text("Log me out")
                        .bold()
                        .padding()
                        .foregroundColor(.blue)
                        .background(.yellow)
                        .cornerRadius(9)
                })
                
                NavigationLink(destination: RegisterView(db: db), label: {
                    Text("Register account")
                        .bold()
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color.yellow)
                        .cornerRadius(9.0)
                })
                
        }
            .frame(width: geometry.size.width, height: geometry.size.height).background(Color.gray)
        }
    }
}

#Preview {
    LoginView(db: DbConnection())
}
