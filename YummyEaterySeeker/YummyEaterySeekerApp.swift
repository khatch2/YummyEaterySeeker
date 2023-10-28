//
//  YummyEaterySeekerApp.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-27.
//

/*
Approved:
• Your app must work in accordance with the app idea you decided from the beginning
• Your project is posted on GitHub
• The app uses a database to save its data
• User system with user-specific data stored in the database
• In your presentation, you must justify why your app looks and functions as it does based on one
user perspective
• The app supports different phone models
• (DONE) App login and splash screen must be present
 */

/*
Well Passed:
• All criteria for passing must be met
• The app uses various native technologies such as maps, camera, calendar, widget, etc
• At least one third-party API integrated
• The app supports dark and light themes
• During the project, Git has been used continuously throughout the project and version history is available
available in the final submission
• The project and code are well structured
• The app is expected to maintain a professional standard when it comes to design and
user experience
• App must include unit tests
*/

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct YummyEaterySeekerApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                
//                ContentView()
                
                SplashScreenView()
            }
        }
    }
}
