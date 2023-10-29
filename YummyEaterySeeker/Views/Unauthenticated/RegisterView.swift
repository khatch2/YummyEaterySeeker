//
//  RegisterView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var db: DbConnection
    
    @StateObject var viewModel = RegisterViewViewModel()
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var birthdate = Date()
    @State var name = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                
                VStack(spacing: 30) {
                    
                    Text(" Register an account ")
                        .bold()
                        .font(.custom("Chalkduster", size: 20))
                        .padding()
                    
                    VStack(spacing: 20) {
                        TextField("Email address", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .padding()
                        
                        SecureField("Password", text: $password).textFieldStyle(.roundedBorder).padding()
                        
                        SecureField("Confirm password", text: $confirmPassword).textFieldStyle(.roundedBorder).padding()
                        
                        TextField("User's name?", text: $name)
                            .textFieldStyle(.roundedBorder).autocorrectionDisabled().padding()
                        
                        DatePicker(
                            selection: $birthdate,
                            label: {
                                
                                Text("Birthdate")
                                    .font(.custom("times", size: 18)).background(Color.cyan)
                        })
                    }.padding()
                    
                    Button(action: {
                        
                        if !email.isEmpty && !password.isEmpty && password == confirmPassword {
                                                        
                            let isSuccess = db.RegisterUser(email: email, password: password, birthdate: birthdate)
                            
                            if !isSuccess {
                                
                                print("Failed to create account")
                                
                                print(" db = ", db)
                            }
                            
                            if (isSuccess == true) {
                                
                                var lookReturnedValueAddrestaurantView = AddRestaurantView(db: DbConnection())
                                
                                print(" lookReturnedValueAddrestaurantView = ", lookReturnedValueAddrestaurantView)
                            }
                            
                        }
                        
                    }, label: {
                        
                        Text("Register")
                            .bold()
                            .font(.custom("times", size: 18))
                            .padding()
                            .foregroundColor(.blue)
                            .background(.mint)
                            .cornerRadius(12)
                    })
                }.background(Color.yellow).padding()
                
            }.background(Color.orange)

            
        }
        
    }
}

#Preview {
    RegisterView(db: DbConnection())
}
