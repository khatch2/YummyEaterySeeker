//
//  DbConnection.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//


import Foundation
import Firebase

class DbConnection: ObservableObject {
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    let USER_DATA_COLLECTION = "user_data_dbconnection"

    @Published var currentUserData: UserData?
    
    @Published var currentUser: User?
    
    var dbListener: ListenerRegistration?
    
    init() {
        
        // Called automatically every time someone logs in or out.
        auth.addStateDidChangeListener { auth, user in
            
            if let user = user {
                
                // A user has just logged in
                print("A user has logged in with email: \(user.email ?? "No Email")")
                
//                self.currentUser = user
                self.currentUser = user
                
                self.startListeningToDb()
                
            } else {
                
                self.dbListener?.remove()
                self.dbListener = nil
                
                // A user has just logged out. Clear all data.
                self.currentUserData = nil
                self.currentUser = nil
                print("User has logged out!")
                
            }
        }
    }

    /*
     I put a listener on our collection "restaurants". At the slightest change in any of the documents in my collection, this function will be called. A copy ("snapshot") is taken of the entire collection after the change and passed as a parameter to the function below. I then have the opportunity to take part in the changes and adapt my app accordingly.
     */
    func startListeningToDb() {
        
        guard let user = currentUser else {return}
        
        dbListener = db.collection(self.USER_DATA_COLLECTION).document(user.uid).addSnapshotListener {
            snapshot, error in
            
            if let error = error {
                print("Error occurred \(error.localizedDescription)")
                return
            }
            
            guard let documentSnapshot = snapshot else { return }
            
            let result = Result {
                try documentSnapshot.data(as: UserData.self)
            }
            
            switch result {
                case .success(let userData):
                    self.currentUserData = userData
                
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
            /*
            for document in snapshot.documents {
                
                let result = Result {
                    try document.data(as: Restaurant.self)
                }
                
                switch result {
                case .success(let restaurant):
                    //self.restaurants.append(restaurant)
                    print(restaurant.name)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
             */
            
        }
    }
    
    func RegisterUser(email: String, password: String, birthdate: Date) -> Bool {
        
        var success = false
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                
                print(error.localizedDescription)
                
                success = false
            }
            
            if let authResult = authResult {
                
                // Create a UserData document in the database
                
                let newUserData = UserData(restaurants: [], birthdate: birthdate)
                
                do {
                    try self.db.collection(self.USER_DATA_COLLECTION).document(authResult.user.uid).setData(from: newUserData)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
                
                print("Account successfully created!")
                
                success = true
            }
        }
        
        return success
    }
    
    func LoginUser(email: String, password: String) -> Bool {
        
        var success = false
        
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            
            if let error = error {
                
                print("Error logging in!")
                
                success = false
            }
            
            if let _ = authDataResult {
                
                print("Successfully logged in!")
                
                success = true
            }
        }
        
        return success
    }
    
    func addRestaurantToDb(restaurant: Restaurant) {
        
        if let currentUser = currentUser {
            
            do {
                
                /*
                 
                 I go into my collection, and then into the document that has the same name as my current user id. There I run an updateData method that updates a field. I give it an arrayUnion, which takes a new array and combines it with the existing array in the database (kind of like the spread operator in javascript). In arrayUnion, I send in an array that has one element, which is a dictionary. To convert my Restaurant struct into a dictionary, I use Firestore.Encoder().encode which takes in a type that is Codable and returns a Dictionary with all its variables as key's and their respective values as values.
                 
                 */
                                
                try db.collection(USER_DATA_COLLECTION).document(currentUser.uid).updateData(["restaurants": FieldValue.arrayUnion([Firestore.Encoder().encode(restaurant)])])
                
                print("Successfully added a restaurant")
                
            } catch {
                
             print("Error adding restaurant")
                
            }
        }
    }
}

