//
//  MapView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-11.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView(frame: .zero)
        
        mapView.mapType = .hybrid /// Set the map type to satellite OR change it to .satelliteFlyover if you want to use the 3D satellite flyover mode.

        // Set an initial region (customize as needed)
        let initialLocation = CLLocationCoordinate2D(latitude: 59.310230470905275, longitude: 18.021426935241518 )
        
        let region = MKCoordinateRegion(center: initialLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        mapView.setRegion(region, animated: true)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the view when needed
    }
}

#Preview {
    
    MapView()
}
