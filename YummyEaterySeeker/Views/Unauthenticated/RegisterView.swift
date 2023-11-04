//
//  RegisterView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack (spacing: 30) {
                
                Image("restaurant-logo").resizable().frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.28, alignment: .center).padding()
                
                Text("Register an account? ").bold().font(.title)
                
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("Email?", text: $email).textFieldStyle(.roundedBorder).font(.custom("times", size: 14)).keyboardType(.emailAddress).textInputAutocapitalization(.never)
                    
                    Text("Password")
                    SecureField("", text: $password).textFieldStyle(.roundedBorder).font(.custom("times", size: 14)).textInputAutocapitalization(.never)
                    
                }.padding()
                
                Button("Register") {
                    dbConnection.RegisterUser(email: email, password: password)
                }.bold().padding().foregroundColor(.blue).background(.yellow).cornerRadius(9)
                
//                Text("Hello, RegisterView")

            }.padding().background(.orange)
        }.background(.yellow)
    }
}

#Preview {
    RegisterView()
}
