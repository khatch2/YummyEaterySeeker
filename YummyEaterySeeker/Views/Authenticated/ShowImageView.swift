//
//  ShowImageView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-02.
//

import SwiftUI
import PhotosUI


struct ShowImageView: View {
    
    @ObservedObject var db: DbConnection
    
    @State var selectedItems: [PhotosPickerItem] = []
    
    @State var data: Data?
    

    
    var body: some View {
        
        VStack(spacing: 30) {
            
            Text("Show image").bold().font(.title)
            
            if let data = data, let uiImage = UIImage(data: data) {
                
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(20)
                
                Button(action: {
                    db.uploadImageToUser(data: data)
                }, label: {
                    Text("Save to db").bold()
                })
                
            }
            
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images) {
                
                Text("Choose image").bold()
                
            }.onChange(of: selectedItems) { newValue in
                
                guard let item = newValue.first else {
                    return
                }
                
                item.loadTransferable(type: Data.self) { result in
                    
                    switch result {
                        case .success(let data):
                            self.data = data
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                }
            }.padding().background(Color.yellow).cornerRadius(9)
        }.background(Color.orange)

    }
}


#Preview {
    ShowImageView(db: DbConnection())
}
