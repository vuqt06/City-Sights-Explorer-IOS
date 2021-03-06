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
    
    @Published var authorizatonStatus = CLAuthorizationStatus.notDetermined
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    @Published var hotels = [Business]()
    @Published var fitness = [Business]()
    @Published var placeMark: CLPlacemark?
    
    override init() {
        // Init medthod of NSObject
        super.init()
        
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        

    }
    func requestLocationPermission() {
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Update the authorizationStatus property
        authorizatonStatus = locationManager.authorizationStatus
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
            locationManager.stopUpdatingLocation()
            
            // Get the user's place mark
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(userLocation!) { placemark, error in
                    // Check there are not errors
                if error == nil && placemark != nil {
                    self.placeMark = placemark?.first
                }
            }
            
            // If we have the coordinates of the user, send it to Yelp API
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.hotelsKey, location: userLocation!)
            getBusinesses(category: Constants.fitnessKey, location: userLocation!)
        }

    }
    
    // MARK: - Yelp API methods
    func getBusinesses(category:String, location:CLLocation) {
        // Create URL
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        let url = URL(string: urlString)
         */
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "20")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            // Create URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                // Check that there is not error
                if error == nil {
                    
                    do {
                        // Parse JSON
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // Sort businesses
                        let businesses = result.businesses.sorted{ b1, b2 in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // Call get image data
                        for business in businesses {
                            business.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            // Assign results to the approriate property
                            print(category)
                            if category == Constants.sightsKey {
                                self.sights = businesses
                            }
                            else if category == Constants.restaurantsKey {
                                self.restaurants = businesses
                            }
                            else if category == Constants.hotelsKey {
                                self.hotels = businesses
                            }
                            else if category == Constants.fitnessKey {
                                self.fitness = businesses
                            }
                        }
                        
                    }
                    catch {
                        print(error)
                    }
                   
                }
            }
            
            // Start the Data Task
            dataTask.resume()
        }

    }
}
