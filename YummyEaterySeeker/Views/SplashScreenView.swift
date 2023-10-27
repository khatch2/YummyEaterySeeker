//
//  SplashScreenView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-27.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // I customised my SplashScreen here
    var body: some View {

        
        if (isActive == true) {

//            DBContentView()
            
        } else {
            GeometryReader { geometry in
                VStack {
                    VStack {
                        VStack {
                            
                            Image("SplashScreenSet").resizable().frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.orange).colorInvert()
                            
                            Text("Online Tic tac toe").font(Font.custom("Times New Roman", size: 26)).foregroundColor(.black.opacity(0.50)).bold()
                        }.scaleEffect(size).opacity(opacity).onAppear{
                            withAnimation(.easeIn(duration: 3.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    }.onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0 /* 5 seconds */) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }.position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5).background(Color.yellow)
                
            }
            
        }
        
        
    }
}


#Preview {
    SplashScreenView()
}
