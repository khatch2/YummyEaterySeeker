//
//  LocationManager.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-07.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    /// I took control of init, from the  parent class (In this case NSObject) .
    override init() {
        
        /// I  made sure to first run the code found in the parent's init
        super.init()
        
        manager.delegate = self
        
    }
    
    func askPermission() {
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
            
            case .authorizedAlways, .authorizedWhenInUse:
            
                manager.startUpdatingLocation()
            
            case .notDetermined, .denied:
            
                askPermission()
            
            case .restricted:
            
                print("Error .restricted")
            
            default:
            
                print("Error default_case")
            
                break
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("User has moved!")
        
    }
    
}

