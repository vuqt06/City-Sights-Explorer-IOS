//
//  ContentModel.swift
//  Ann Arbor City Sights
//
//  Created by Vu Trinh on 1/18/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        // Init medthod of NSObject
        super.init()
        
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    // MARK - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            // We have permission
            // TODO: Start geolocation the user after we get permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            // We don't have permission
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Give the location of the user
        let userLocation = locations.first
        if userLocation != nil {
            // Stop requesting the location after we get one
            locationManager.startUpdatingLocation()
        }
        
        // If we have the coordinates of the user, send it to Yelp API
        //getBusinesses(category: "arts", location: userLocation!)
        getBusinesses(category: "restaurants", location: userLocation!)

    }
    
    // MARK: - Yelp API methods
    func getBusinesses(category:String, location:CLLocation) {
        // Create URL
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        let url = URL(string: urlString)
         */
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: String(category)),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer zGmz1ZwnWFcuKOifylEkyYCsNSjFw2-S1l74eMYOkyRXRkPFM2yAqviKGWOm1RlUUWjM3UCLmmvH7eEV3wjTtjLSHiTPWrqL81fupLtFSdRUGVEO6d3OaHV3NXHnYXYx", forHTTPHeaderField: "Authorization")
            // Create URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                // Check that there is not error
                if error == nil {
                    print(response)
                }
            }
            
            // Start the Data Task
            dataTask.resume()
        }

    }
}
