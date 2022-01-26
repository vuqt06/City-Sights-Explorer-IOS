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
    @Binding var selcectedBusiness:Business?
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
        mapView.delegate = context.coordinator
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
    
    // MARK - Coordinator class
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var map:BusinessMap
        
        init(map: BusinessMap) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // If annotation is the use blue dot, return nil
            if annotation is MKUserLocation {
                return nil
            }
            
            // Check if there is a resuable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            if annotationView == nil {
                // Create a new one
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            }
            else {
                // We got a reusable one
                annotationView!.annotation = annotation
            }
            // Create an annotation view
            
            // Return the view
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            // User tapped on annotations
            
            // Get the Business object that the annotation presents
            // Loop through businesses in model to find and match
            
            for business in map.model.restaurants + map.model.sights {
                if (business.name == view.annotation?.title) {
                    map.selcectedBusiness = business
                    return
                }
            }
            
            
            // Set the selectedBusiness to that business
        }
    }
}
