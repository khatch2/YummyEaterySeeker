//
//  RegisterView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

//import SwiftUI
//
//struct RegisterView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import Foundation
import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var db: DbConnection
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var birthdate = Date()
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text("Register an account").bold().font(.title).padding()
            
            VStack(spacing: 20) {
                TextField("Email address", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $password).textFieldStyle(.roundedBorder)
                SecureField("Confirm password", text: $confirmPassword).textFieldStyle(.roundedBorder)
                
                DatePicker(selection: $birthdate, label: {
                    Text("Birthdate")
                })
            }.padding()
            
            Button(action: {
                
                if !email.isEmpty && !password.isEmpty && password == confirmPassword {
                    
                    let isSuccess = db.RegisterUser(email: email, password: password, birthdate: birthdate)
                    
                    if !isSuccess {
                        print("Failed to create account")
                    }
                    
                }
                
            }, label: {
                Text("Register")
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(9)
            })
        }
        
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView(db: DbConnection())
//    }
//}


#Preview {
    RegisterView(db: DbConnection())
}
