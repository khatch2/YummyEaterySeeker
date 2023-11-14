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
    
    @Published var txtInfo : String = "n/a"
    
    @Published var restaurantsList : [Restaurant] = []
    
    @Published var localAndGlobalRestaurantsList : [Restaurant] = []
    
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
                    
            /// I called it automatically every time someone logs in or out.
            auth.addStateDidChangeListener { auth, user in
                
                if let user = user {
                    
                    /// A user has just logged in
                    print("A user has logged in with email: \(user.email ?? "No Email")")
                    
                    self.txtInfo = "A user has logged in with email: \(user.email ?? "No Email")"
                    
                    self.userHasLoggedIn = true
                    
                    self.currentUser = user
                    
                    self.startListeningToDb()
                    
                } else {
                    
                    self.userHasLoggedIn = false
                    
                    self.dbListener?.remove()
                    self.dbListener = nil
                    
                    /// A user has just logged out. Clear all data.
                    self.currentUserData = nil
                    self.currentUser = nil
                    
                    print("User has logged out!")
                    
                    self.txtInfo = "User has logged out!"
                    
                }
            }
        }
    
    func getAllDocumentIDs(collectionPath: String, completion: @escaping ([String]?, Error?) -> Void) {
        
        let db = Firestore.firestore()

        db.collection(collectionPath).getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            if let documents = snapshot?.documents {
                let documentIDs = documents.map { 
                    $0.documentID
                }
                completion(documentIDs, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func addEvaluationToRestaurant(restaurantId: String, evaluation: Evaluation) {
        
        /// DONE : Fix the right address according to what console has shown.
        do {
                            
                try db.collection(LILJEHOLMEN_DATA_COLLECTION).document(restaurantId).updateData(
                    ["reviews" : FieldValue.arrayUnion(
                        [Firestore.Encoder().encode( evaluation )]
                    )]
                )
                
        } catch {
            
            print(" 110 ", error.localizedDescription)
            
            print("Error adding review!")
            
            txtError = "Error adding review! \(error.localizedDescription) ."
            
        }
        
    }
    
    func getRestaurantImage(completion: @escaping (UIImage?) -> Void) {
            
            guard let currentUserData = currentUserData else {return}
            
            print("Image Path \(currentUserData.image)")
            
            txtInfo = "Image Path \(currentUserData.image)"
            
            storageManager.getImageByPath(path: currentUserData.image, completion: { image in
                
                completion(image)
                
            })
        }
        
    /**
         I put a listener on our collection "restaurants". At the slightest change in any of the documents in our collection, this function will be called. A copy ("snapshot") is taken of the entire collection after the change and passed it as a parameter to the function below. I, then have the opportunity to take part in the changes and adapt my app accordingly.
         */
    func startListeningToDb() {

            guard let user = currentUser else {return}
            
            print("START LISTENING")
            
            var dbCollectionRef = db.collection(self.LILJEHOLMEN_DATA_COLLECTION)
        
            print(type(of: dbCollectionRef))
            print(dbCollectionRef)
            print()
            
            dbListener =  dbCollectionRef.addSnapshotListener { (snapshot, err) in
                                    
                    if let err = err {
                        
                        print("Error occurred \(err.localizedDescription)")
                        
                        self.txtError = "Error occurred \(err.localizedDescription)"
                        
                        return
                    }
                
                print()
                print("Look here, second document's id = ", snapshot?.documents[1].documentID ?? "N/A")
                print()
                    
                guard let thisSnapshot = snapshot else { return }
                    
                var fetchedRestaurants: [Restaurant] = []
                        
                for doc in thisSnapshot.documents {
                            
                            let result = Result {
                                
                                try doc.data(as: Restaurant.self)
                                
                            }
                            
                            switch result {
                                
                                case .success(let restaurant):
                                
                                    fetchedRestaurants.append(restaurant)
                                
                                    print()
                                    print("SUCCESS ")
                                    print(doc.data())
                                    print()
                                
                                case .failure(let error):
                                
                                    print()
                                    print(">ERROR< ")
                                    print(doc.data() )
                                    print(error.localizedDescription)
                                    print()
                            }
                            
                }
                
                self.restaurantsList = fetchedRestaurants
                
                self.localAndGlobalRestaurantsList.append(contentsOf: self.restaurantsList)
                
                print()
                print(" localAndGlobalRestaurantList LINE [229] ", self.localAndGlobalRestaurantsList)
                print()
                    
            }
        
            print(type(of: dbListener))
            print(dbListener.debugDescription, " ; ", dbListener?.description)
            print()
        
        getAllDocumentIDs(collectionPath: LILJEHOLMEN_DATA_COLLECTION) { (documentIDs, error) in
            
            if let error = error {
                    print("Error getting document IDs: \(error.localizedDescription)")
                
                } else if let documentIDs = documentIDs {
                    print("Document IDs: \(documentIDs)")
                    
                } else {
                    print("No documents found in the collection.")
            }
            
        }
                
    }
            
        func RegisterUser(email: String, password: String) -> Bool {
            
            var success = false
            
            auth.createUser(withEmail: email, password: password) { authResult, error in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    self.txtError = error.localizedDescription
                    
                    success = false
                    
                }
                
                if let authResult = authResult {
                    
                    /// I created a UserData document in the database
                    let newUserData = UserData(restaurants: [], image: "")
                    
                    do {
                        
                        try self.db.collection(self.LILJEHOLMEN_DATA_COLLECTION).getDocuments {(querySnappshot, err) in
                                
                                if err != nil {
                                    
                                    print(err?.localizedDescription)
                                
                                self.txtError = err?.localizedDescription ?? "n/a"
                                
                                return
                                    
                            }
                            
                            print(" querySnappshot?.documents ", querySnappshot?.documents)
                            
                        }
                    } catch {
                        
                        self.txtError = error.localizedDescription
                        
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
                    /**
                     I went into my collection, and then into the document that has the same name as my current user's id. There I run an updateData method that updates a field. I gave it an arrayUnion, which takes a new array and combines it with the existing array in the database (kind of like the spread operator in javascript). In arrayUnion, I send in an array that has one element, which is a dictionary. To convert my Restaurant struct into a dictionary, I use Firestore.Encoder().encode which takes in a type that is Codable and returns a Dictionary with all its variables as key's and their respective values as values.
                     */
                    try db.collection(LILJEHOLMEN_DATA_COLLECTION).document().setData( ["restaurants": FieldValue.arrayUnion([Firestore.Encoder().encode(restaurant)])] )
                    
                } catch {
                    
                    print("Error adding restaurant")
                    
                    txtError = "Error adding restaurant"
                }
            }
        }
    }
