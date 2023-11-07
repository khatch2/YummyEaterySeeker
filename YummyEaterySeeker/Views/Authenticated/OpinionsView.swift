//
//  ReviewPopup.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import SwiftUI

struct OpinionsView: View {
    
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
        
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                
                Spacer()
                
                Text("Write down your opinions, please?").bold().font(.title)
                
                VStack(alignment: .leading) {
                    
                    Text("Your name?")
                    
                    TextField("", text: $name)
                    
                    Text("Your opinions?")
                    
                    TextField("", text: $opinions)
                    
                }.padding().textFieldStyle(.roundedBorder)
                
                Button(action: conformOpinion, label: {
                    Text("Conform").padding().background(.black).foregroundColor(.white).cornerRadius(9)
                })
                
            }
            
            
        }.frame(width: 300, height: 360).cornerRadius(9).background( .orange )
        
        Text("Hello, OpinionsView")
        
    }
}
    


#Preview {
//    Opin
    OpinionsView(restaurantId: "HelloEveryOne", showPopup: .constant(true))
}

