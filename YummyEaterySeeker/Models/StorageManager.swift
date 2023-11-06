//
//  StorageManager.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-06.
//

import Foundation
import FirebaseStorage
import Firebase

class StorageManager {
    
    let storageRef = Storage.storage()
    
    func uploadImage (data: Data, completion: @escaping (String?) -> Void) {
        
        let imageName = UUID().uuidString.lowercased()
        
        let imageRef = storageRef.reference().child( "images/\(imageName).jpg")
        
        imageRef.putData(data, metadata: nil) { (metadata, error) in
            
            if let error = error {
                print("Error uploading image, i.e: \(error.localizedDescription)")
                
                completion(nil)
                
                return
            }
            
            guard let path = metadata?.path else { return }
            
            completion(path)
            
            print("image successfully uploaded to path: \(path) ")
        }
        
    }
    
    func getImageByPath (path: String, completion: @escaping (UIImage?) -> Void) {
        
        let imageRef = storageRef.reference().child(path)
        
        imageRef.getData(maxSize: 1 * 1024 * 4096) { (data, error) in
            if let error = error {
                print("error is: ", error)
                completion(nil)
                return
            }
            
            guard let data = data else {return}
            
            let image = UIImage(data: data)
            
            completion(image)
        }
    }
    
    func getImageUrlByPath (path: String, completion: @escaping (URL?) -> Void) {
        
        let imageRef = storageRef.reference().child(path)
        
        imageRef.downloadURL { (url, error) in
            
            if let error = error {
                print("Error generating URL, i.e. error is: \(error.localizedDescription)")
                
                completion(nil)
            }
            
            if let url = url {
                completion(url)
            }
        }
    }
    
    
    
}
