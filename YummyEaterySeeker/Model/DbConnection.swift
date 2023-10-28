//
//  DbConnection.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

//import SwiftUI
//
//struct DbConnection: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import Foundation
import Firebase

class DbConnection: ObservableObject {
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    let USER_DATA_COLLECTION = "user_data"

    @Published var currentUserData: UserData?
    @Published var currentUser: User?
    
    var dbListener: ListenerRegistration?
    
    init() {
        
        // Kallas automatiskt på varje gång någon loggar in eller ut.
        auth.addStateDidChangeListener { auth, user in
            
            if let user = user {
                
                // En användare har precis loggat in
                print("A user has logged in with email: \(user.email ?? "No Email")")
                
                self.currentUser = user
                
                
                
                self.startListeningToDb()
                
            } else {
                
                self.dbListener?.remove()
                self.dbListener = nil
                
                // En användare har precis loggat ut. Rensa all data.
                self.currentUserData = nil
                self.currentUser = nil
                print("User has logged out!")
                
            }
            
        }
        
    }

    
    /*
    Vi sätter en lyssnare på våran collection "restaurants". Vid minsta förändring i någon av dokumenten som finns i våran collection, så kommer den här funktionen att kallas på. En kopia ("snapshot") tas av hela kollektionen efter förändringen och skickas in som en parameter till funktionen nedan. Vi har då möjlighet att kunna ta del av förändringarna och anpassa våran app utefter det.
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
                
                // Skapa en UserData dokument i databasen
                
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
                 
                 Vi går in i våran collection, och sedan in i dokumentet som har samma namn som våran nuvarande användares id. Där kör vi en updateData metod som uppdaterar ett fält. Vi ger den en arrayUnion, som tar en ny array och kombinerar den ihop med den existerande arrayen som finns i databasen (typ som spread operator i javascript). I arrayUnion så skickar vi in en array som har ett element, som är en dictionary. För att omvandla våran Restaurant struct till en dictionary, så använder vi oss utav Firestore.Encoder().encode som tar in en typ som är Codable och returnerar en Dictionary med alla dess variabler som key's och deras respektive värden som values.
                 
                 */
                
                // ["FÄLTETS_NAMN": NYA_VÄRDET_SOM_DU_VILL_TILLSÄTTA]
                
                try db.collection(USER_DATA_COLLECTION).document(currentUser.uid).updateData(["restaurants": FieldValue.arrayUnion([Firestore.Encoder().encode(restaurant)])])
                
            } catch {
                
             print("Error adding restaurant")
            }
            
            
        }
    }
    
}

//#Preview {
//    DbConnection()
//}
