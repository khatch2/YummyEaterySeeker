//
//  ReviewPopup.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct OpinionsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var db: DbConnection
        
    @State var name = ""
    
    @State var opinions = ""
    
    var restaurantId : String
    
    @Binding var showPopup: Bool
    
    func conformOpinion() {
        
        if name == "" || opinions == "" {
            
            print("You should fill all fields here!")
            
            return
        }
        
        let newEvaluation = Evaluation(id: UUID().uuidString.lowercased(), name: name, message: opinions)
                
        db.addEvaluationToRestaurant(restaurantId: restaurantId, evaluation: newEvaluation)
        
        dismiss()
        
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView {
                
                VStack {
                    
                    Spacer()
                    
                    Text("Write down your opinions, please?").bold().font(.title).background(.brown)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Your name?").background(.orange)
                        
                        TextField("", text: $name)
                        
                        Text("Your opinions?").background(.orange)
                        
                        TextField("", text: $opinions)
                        
                    }.padding().textFieldStyle(.roundedBorder)
                    
                    Button(action: conformOpinion, label: {
                        
                        Text("Conform") /* .background(.yellow) */.foregroundColor(.blue).cornerRadius(9)
                        
                    })
                    
                }

                
            }
            
            
            
        }.frame(width: 300, height: 360).cornerRadius(20).background( .gray ).padding()
        
    }
}

#Preview {
    
    OpinionsView(restaurantId: "HelloEveryOne", showPopup: .constant(true))
    
}

