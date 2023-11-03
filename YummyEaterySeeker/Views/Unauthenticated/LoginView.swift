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
                
                Text("Hello, LoginView")

            }

        }
        
    }
}

#Preview {
    LoginView()
}
