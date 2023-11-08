//
//  RegisterView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI
import SimpleToast

struct RegisterView: View {
    
//    @State var showToast : Bool = true
    
    private let toastOptions = SimpleToastOptions(
            hideAfter: 3
    )
    
    @EnvironmentObject var db: DbConnection
    
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
                    
                }.background(.yellow).padding()
                
                Button("Register") {
                    db.RegisterUser(email: email, password: password)
//                    dbConnection.RegisterUser(email: email, password: password)
                    
                }.bold().padding().foregroundColor(.blue).background(.yellow).cornerRadius(9)
                
                Text(db.txtError)
                
            }.padding().background(.orange)
        }.background(.yellow)
//            .alert(Text("Error"), isPresented: $showToast, actions: {
//            Text("Hello")
//        })
    }
}

#Preview {
    RegisterView()
}
