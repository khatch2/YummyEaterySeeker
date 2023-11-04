//
//  ReviewPopup.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct ReviewPopupView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var name = ""
    @State var message = ""
    
    var restaurantId : String
    
    @Binding var showPopup: Bool
    
    func submitReview() {
        
        if name == "" || message == "" {
            
            print("No empty fields allowed here!")
            
            return
        }
        
        let newReview = Review(id: UUID().uuidString, name: name, message: message)
        
        dbConnection.addReviewToRestaurant(restaurantId: restaurantId, review: newReview)
        
        showPopup.toggle()
    }

    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack (spacing: 30) {
                
                ZStack() {
                    
//                    Color.lightPrimaryColor
                    
                    VStack {
                        Spacer()
                        
                        Text("Write a review?").bold().font(.title)
                        
                        VStack(alignment: .leading) {
                            
                            Text("Name?")
                            
                            TextField("", text: $name)
                            
                            Text("Message?")
                            
                            TextField("", text: $message)
                            
                        }.padding().textFieldStyle(.roundedBorder)
                        
                        Button(action: submitReview, label: {
                            Text("Submit").padding().background(.black).foregroundColor(.white).cornerRadius(9)
                        })
                        
                        Button(action: {
                            
                            showPopup.toggle()
                            
                        }, label: {
                            
                            Text("Cancel").foregroundColor(.brown).padding(.vertical)
                        })
            
                    }
                    
                    
                }.frame(width: 300, height: 360).cornerRadius(9).background( .orange )
                
                Text("Hello, ReviewPopup")

            }.padding().background(.yellow)
        }.background(.brown)
    }
}

#Preview {
    ReviewPopupView(restaurantId: "Hejsan", showPopup: .constant(true))
}
