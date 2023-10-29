//
//  RegisterViewViewModel.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import Foundation

import FirebaseAuth

import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {
    
    @Published var name = ""
    
    @Published var email = ""
    
    @Published var password = ""
    
    @Published var errorMsg = ""
    
    init(name: String = "", email: String = "", password: String = "") {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func register () {
        
        guard validate() else {return}
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            
            guard let userId = result?.user.uid else {return}
            
            print(" userId = ", userId)
            
            self.insertUserRecord()
        })
    }
    
    func validate() -> Bool {
                
        guard password.count < 8 else {
            
            print("By the way: the password must be at least 8 characters long.")
            errorMsg = "By the way: the password must be at least 8 characters long."
            
            return false
        }
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty ||
                !email.trimmingCharacters(in: .whitespaces).isEmpty ||
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMsg = "You should write in all obligatory fields *"
            
            return false
            
        }
        
        return true
    }
    
    func insertUserRecord( /* id: String */ ) {
        
        let newuser = UserMe(name: name, email: email, joinedTime: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        print(" db = ", db)
        
    }
    
}
