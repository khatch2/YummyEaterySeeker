//
//  RegisterView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI
import SimpleToast

struct RegisterView: View {
    
    
    @EnvironmentObject var db: DbConnection
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var email = ""
    
    @State var password = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView {
                
                VStack (spacing: 30) {
                    
                    Image("restaurant-logo").resizable().frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.28, alignment: .center).padding()
                    
                    Text("Register an account? ").bold().font(.title).background(colorScheme == .dark ? .black : .white).foregroundColor(colorScheme == .dark ? .brown : .indigo)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Email")
                        TextField("Email?", text: $email).textFieldStyle(.roundedBorder).font(.custom("times", size: 14)).keyboardType(.emailAddress).textInputAutocapitalization(.never).background(colorScheme == .dark ? .black : .white).foregroundColor(colorScheme == .dark ? .brown : .indigo)
                        
                        Text("Password")
                        SecureField("", text: $password).textFieldStyle(.roundedBorder).font(.custom("times", size: 14)).textInputAutocapitalization(.never).background(colorScheme == .dark ? .black : .white).foregroundColor(colorScheme == .dark ? .brown : .indigo)
                        
                    } // .background(.yellow).padding()
                    
                    Button("Register") {
                        
                        var resultRegistering = db.RegisterUser(email: email, password: password)
                        
                        print(" resultRegistering = ", resultRegistering)
                        
                    }.bold().foregroundColor(.blue) /* .background(.yellow) */ .cornerRadius(9).background(colorScheme == .dark ? .black : .white).foregroundColor(colorScheme == .dark ? .brown : .indigo)
                    
                    Text(db.txtError).background(colorScheme == .dark ? .black : .white).foregroundColor(colorScheme == .dark ? .brown : .indigo)
                    
                }.padding().background(.orange)

            }
            
        } // .background(.yellow)
    }
}

#Preview {
    
    RegisterView()
    
}
