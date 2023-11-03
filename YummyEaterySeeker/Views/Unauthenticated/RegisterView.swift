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
            
            VStack () {
                
                Text("Hello, RegisterView")

            }
        }
    }
}

#Preview {
    RegisterView()
}
