//
//  BusinessMap.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/24/22.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model:ContentModel
    var locations:[MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        // Create a set of annotations from our list of business
        for business in model.restaurants + model.sights {
            // If business has a lat/long
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                // Create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        return annotations
    }
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // TODO: Set the region
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add he ones based on the business
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}
