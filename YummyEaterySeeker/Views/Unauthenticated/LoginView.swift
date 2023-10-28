//
//  LoginView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

//import SwiftUI
//
//struct LoginView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import Foundation
import SwiftUI

/*
 
 Varje view har en koordinatsystem. Om vi har en view med storleken 100 with och 100 height, så skulle koordinaten x: 50, y: 50 motsvara mittpunkten i den viewn.
 
 När vi sätter .position på en komponent som befinner sig inom våran view (alltså child-komponent), så anger vi komponentens mittpunkt inom parent viewn's koordinatsystem.
 
 */

struct LoginView: View {
    
    @ObservedObject var db: DbConnection
    
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .center, spacing: 30) {
            
                Image("restaurant-logo").resizable().frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.28, alignment: .center).padding()
            
            Text("Welcome to Restaurant Finder!")
                .bold()
                .font(.system(size: 24)).padding(.bottom, geometry.size.height * 0.02)
                
                VStack(alignment: .leading) {
                    Text("Enter your credentials").font(.title3).bold()
                    
                    TextField("Email address", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password).textFieldStyle(.roundedBorder)
                    
                }.padding()
                
                Button(action: {
                    
                    if !email.isEmpty && !password.isEmpty {
                        // Logga in användaren
                    }
                    
                }, label: {
                    Text("Log in")
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(9)
                })
                
                NavigationLink(destination: RegisterView(db: db), label: {
                    Text("Register account").bold().padding().foregroundColor(.black)
                })
            
            
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
        }
        
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(db: DbConnection())
//    }
//}

#Preview {
    LoginView(db: DbConnection())
}
