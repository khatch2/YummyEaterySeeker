//
//  Color.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-03.
//

import Foundation
import SwiftUI

extension Color {
    
    static var primaryColor: Color {
        
        Color( UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) : UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1) } )
    }
    
    static var lightPrimaryColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1) : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1) })
    }
    
    static var secondaryColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1) : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) })
    }
    
}
