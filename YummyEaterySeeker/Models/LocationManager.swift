//
//  LocationManager.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-29.
//

import Foundation

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    // We take control of init, from our parent class (In this case NSObject)
    override init() {
        
        // We make sure to first run the code found in our parent's init
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

