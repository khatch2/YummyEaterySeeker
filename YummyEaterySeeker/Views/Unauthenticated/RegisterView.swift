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
                    TextField("", text: $email).textFieldStyle(.roundedBorder)
                    
                    Text("Password")
                    SecureField("", text: $password).textFieldStyle(.roundedBorder)
                }.padding()
                
                Button("Register") {
                    dbConnection.RegisterUser(email: email, password: password)
                }.foregroundColor(.blue).background(.yellow).cornerRadius(3)
                
//                Text("Hello, RegisterView")

            }.padding()
        }
    }
}

#Preview {
    RegisterView()
}
