//
//  ListRestaurantsView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

//import SwiftUI
//
//struct ListRestaurantsView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import Foundation
import SwiftUI


struct ListRestaurantsView: View {
    
    @ObservedObject var db: DbConnection
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Restauranger").font(.title).bold().padding()
                
                if let userData = db.currentUserData {
                    
                    if userData.restaurants.count < 1 {
                        Text("No restaurants yet!")
                    } else {
                        List() {
                            ForEach(userData.restaurants) { restaurant in
                                Text(restaurant.name)
                            }
                        }
                    }

                    
                } else {
                    
                    Text("Unexpected error, please contact your administrator.")
                    
                }
            
                NavigationLink(destination: AddRestaurantView(db: db), label: {
                    Text("Add Restaurant").bold().padding().foregroundColor(.white).background(.black).cornerRadius(9)
                })
            }
        }
    }
}

//struct ListRestaurantsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRestaurantsView(db: DbConnection())
//    }
//}


#Preview {
    ListRestaurantsView(db: DbConnection())
}
