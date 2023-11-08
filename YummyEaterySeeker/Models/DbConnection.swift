//
//  DbConnection.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-06.
//

import Foundation
import Firebase

class DbConnection: ObservableObject {
    
    @Published var txtError: String = "N/A"
    
    @Published var restaurantsList : [Restaurant] = []
    
    private var RESTAURANT_COLLECTION = "Restaurants"
    
    var db = Firestore.firestore()
    
    var auth = Auth.auth()
    
    var storageManager = StorageManager()
    
    let LILJEHOLMEN_DATA_COLLECTION = "restaurants_in_near_liljeholmen"
    
    @Published var userHasLoggedIn = false
    
    @Published var currentUserData: UserData?
    
    @Published var currentUser: User?
        
    var dbListener: ListenerRegistration?
    
    
    init() {
            
            // Called automatically every time someone logs in or out.
            auth.addStateDidChangeListener { auth, user in
                
                if let user = user {
                    
                    // A user has just logged in
                    print("A user has logged in with email: \(user.email ?? "No Email")")
                    
                    self.userHasLoggedIn = true
                    
                    self.currentUser = user
                    
                    self.startListeningToDb()
                    
                } else {
                    
                    self.userHasLoggedIn = false
                    
                    self.dbListener?.remove()
                    self.dbListener = nil
                    
                    // A user has just logged out. Clear all data.
                    self.currentUserData = nil
                    self.currentUser = nil
                    print("User has logged out!")
                    
                }
            }
        }
        
//        func uploadImageToUser(data: Data) {
//            
//            // We only upload the image if a user is logged in
//            guard let currentUser = currentUser else {return}
//            
//            storageManager.uploadImage(data: data) { path in
//                
//                // If we haven't received a path, then the upload has failed, and we end the function here
//                guard let path = path else {return}
//                
////                self.db.collection(self.USER_DATA_COLLECTION).document(currentUser.uid).updateData(["image": path])
//                var lookLiljeholmen = self.db.collection(self.LILJEHOLMEN_DATA_COLLECTION)
//                
//                print()
//                print(type(of: lookLiljeholmen))
//                print("lookLiljeholmen ", lookLiljeholmen)
//                print()
//                
//                var dbCollectionRef = self.db.collection(self.LILJEHOLMEN_DATA_COLLECTION)
//                
//                dbCollectionRef.getDocuments () { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                      } else {
//                          
//                        for document in querySnapshot!.documents {
//                            
//                          print("\(document.documentID) => \(document.data())")
//                        
//                        }
//                      }
//                }
//                
//            }
//        }
    
    func addEvaluationToRestaurant(restaurantId: String, evaluation: Evaluation) {
        
        do {
            try db.collection(RESTAURANT_COLLECTION).document(restaurantId).updateData(
                ["evaluations": FieldValue.arrayUnion(
                    [Firestore.Encoder().encode(evaluation)] )] )
                        
        } catch {
            
            print("Error adding review!")
            
        }
        
    }
    
        
        func getRestaurantImage(completion: @escaping (UIImage?) -> Void) {
            
            guard let currentUserData = currentUserData else {return}
            
            print("Image Path \(currentUserData.image)")
            
            storageManager.getImageByPath(path: currentUserData.image, completion: { image in
                
                completion(image)
                
            })
        }
        
        /*
         We put a listener on our collection "restaurants". At the slightest change in any of the documents in our collection, this function will be called. A copy ("snapshot") is taken of the entire collection after the change and passed as a parameter to the function below. We then have the opportunity to take part in the changes and adapt our app accordingly.
         */
        func startListeningToDb() {

            guard let user = currentUser else {return}
            
            print("START LISTENING")
            
            var dbCollectionRef = db.collection(self.LILJEHOLMEN_DATA_COLLECTION)
            
            dbListener =  dbCollectionRef.addSnapshotListener { (snapshot, err) in
                                    
                    if let err = err {
                        print("Error occurred \(err.localizedDescription)")
                        return
                    }
                
//                print("Look here", snapshot?.documents ?? "N/A")
                    
                guard let thisSnapshot = snapshot else { return }
                    
                var fetchedRestaurants: [Restaurant] = []
                        
                for doc in thisSnapshot.documents {
                            
                            let result = Result {
                                try doc.data(as: Restaurant.self)
                            }
                            
                            switch result {
                                case .success(let restaurant):
                                    fetchedRestaurants.append(restaurant)
//                                    print()
//                                    print("SUCCESS ")
//                                    print(doc.data())
//                                    print()
                                
                                case .failure(let error):
                                    print()
                                print(">ERROR< ")
                                print(doc.data() )
                                    print(error.localizedDescription)
                                print()
                            }
                            

                }
                
                self.restaurantsList = fetchedRestaurants
                    
                    

                
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
            
            
//        }
        
        func RegisterUser(email: String, password: String) -> Bool {
            
            var success = false
            
            auth.createUser(withEmail: email, password: password) { authResult, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    success = false
                }
                
                if let authResult = authResult {
                    
                    // Create a UserData document in the database
//                    let newUserData = UserData(restaurants: [], birthdate: birthdate, image: "")
                    let newUserData = UserData(restaurants: [], image: "")
                    
                    do {
//                        try self.db.collection(self.USER_DATA_COLLECTION).document(authResult.user.uid).setData(from: newUserData)
                        try self.db.collection(self.LILJEHOLMEN_DATA_COLLECTION).getDocuments {(querySnappshot, err) in
                            if err != nil {
                                print(err?.localizedDescription)
                                return
                            }
                            
                            print(" querySnappshot?.documents ", querySnappshot?.documents)
                            
                        }
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
                    
                    self.txtError = "Error logging in!"
                    
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
                     We go into our collection, and then into the document that has the same name as our current user's id. There we run an updateData method that updates a field. We give it an arrayUnion, which takes a new array and combines it with the existing array in the database (kind of like the spread operator in javascript). In arrayUnion, we send in an array that has one element, which is a dictionary. To convert our Restaurant struct into a dictionary, we use Firestore.Encoder().encode which takes in a type that is Codable and returns a Dictionary with all its variables as key's and their respective values as values.
                     */
                    
//                    try db.collection(USER_DATA_COLLECTION).document(currentUser.uid).updateData(["restaurants": FieldValue.arrayUnion([Firestore.Encoder().encode(restaurant)])])
                    try db.collection(LILJEHOLMEN_DATA_COLLECTION).document().setData( ["restaurants": FieldValue.arrayUnion([Firestore.Encoder().encode(restaurant)])] )
                    
                } catch {
                    
                    print("Error adding restaurant")
                }
            }
        }
    
    }
    
    

