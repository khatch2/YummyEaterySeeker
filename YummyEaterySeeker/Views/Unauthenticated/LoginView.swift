//
//  LoginView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack (spacing: 30) {
                
                Image("restaurant-logo").resizable().frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.28, alignment: .center).padding()
                
                Text("Enter your credentials? ").bold().font(.title)
                
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("", text: $email).textFieldStyle(.roundedBorder)
                    
                    Text("Password")
                    SecureField("", text: $password).textFieldStyle(.roundedBorder)
                }.padding()
                
                Button("Login") {
                    dbConnection.LoginUser(email: email, password: password)
                }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).background(.yellow).cornerRadius(9)
                
                NavigationLink(destination: RegisterView(), label: {
                    Text("Register an account").foregroundColor(Color(UIColor {
                        $0.userInterfaceStyle == .dark ? UIColor(.white) : UIColor(.black)
                    })).bold()
                })
                
//                Text("Hello, LoginView")

            }.padding()

        }
        
    }
}

#Preview {
    LoginView()
}
