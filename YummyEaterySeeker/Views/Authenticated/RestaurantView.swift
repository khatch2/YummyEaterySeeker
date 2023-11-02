//
//  RestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-01.
//

import SwiftUI

extension Image {
    init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            print("Error in converting from String to Data")
            return nil }
        
        guard let uiImage = UIImage(data: data) else {
            print("Error in convering from Data to UIImage")
            print(data.description)
            print()
            return nil }
        
        self = Image(uiImage: uiImage)
    }
}

struct RestaurantView: View {
    
    @ObservedObject var db: DbConnection
    
    @State var userImage: UIImage?
    
    var restaurantStation: RestaurantStation
    
    
    var body: some View {
        
        VStack {
            
            NavigationLink(destination: DetailsScreenView(restaurantStation: restaurantStation), label: {
                
                HStack {
                    
//                    let swiftUI = Image(base64String: base64String)
                    
                    if let userImage = userImage {
                        
                        Image(uiImage: userImage).resizable().frame(width: 200, height: 200, alignment: .center).cornerRadius(20)
                        
                    }
                    
                }.foregroundColor(.white).background(Color.green)
            })
            
//            NavigationLink(destination:
//                                            
//                                UploadImageView(db: db), label: {
//                                Text("Add Image").bold().padding().foregroundColor(.blue).background(.yellow).cornerRadius(9)
//                            })
            
            NavigationLink(destination:
                                            
                                ShowImageView(db: db), label: {
                                Text("Show Image").bold().padding().foregroundColor(.blue).background(.yellow).cornerRadius(9)
                            })
            
            
            
        }.onAppear {
            
            print("VStack {}.onAppear {}")
            
            db.getRestaurantImage { image in
                
                self.userImage = image
                
                
                
            }
        }
    }
}
            
                
#Preview {
    RestaurantView(db: DbConnection(), restaurantStation: RestaurantStation(name: "String", latitude: 0, longitude: 0))
}
