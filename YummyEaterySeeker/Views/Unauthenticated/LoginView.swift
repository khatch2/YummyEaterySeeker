//
//  LoginView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI


struct LoginView: View {
    
    @EnvironmentObject var db: DbConnection
    
    @State var email = ""
    
    @State var password = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView {
                
                VStack () {
                    
                    Image("restaurant-logo").resizable().frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.28, alignment: .center).padding()
                    
                    Text("Welcome to Yummy Seeker!").bold().font(.system(size: 24, design: .serif)).italic().padding(.bottom, geometry.size.height * 0.02)
                    
                    Text("Enter your credentials? ").font(.system(size: 20, design: .serif)).bold().italic()
                    
                    VStack(alignment: .leading) {
                        Text("E-post")
                        TextField("Email address?", text: $email).textFieldStyle(.roundedBorder).font(.custom("times", size: 14)).keyboardType(.emailAddress).textInputAutocapitalization(.never)
                        
                        /// Watchword, i.e.: password
                        Text("Watchword")
                        SecureField("Password?", text: $password).textFieldStyle(.roundedBorder).font(.custom("times", size: 14))
                    }.background(.yellow).padding()
                    
                    /// N/A
                    Text(db.txtError)
                    
                    HStack {
                        
                        Button("Login") {
                            
                            let resultLogingIn =  db.LoginUser(email: email, password: password)
                            
                            print(" resultLogingIn = ", resultLogingIn)
                            
                        }.bold().padding().foregroundColor(.blue).background(.yellow).cornerRadius(9)
                        
                        NavigationLink(destination: RegisterView(), label: {
                            
                            Text("Register an account").bold().foregroundColor(.blue).background(.yellow).cornerRadius(9)
                            }).bold()
                                .padding()
                                .foregroundColor(.blue)
                                .background(Color.yellow)
                                .cornerRadius(9.0)
                        
                    }
                                    
                }.padding().background(.orange)
                
            }.frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.85, alignment: .center)

        }.background(.yellow)
    }
}

#Preview {
    
//    @Binding var txtError: String = projectedValue
    LoginView().environmentObject(DbConnection())
    
}
