//
//  Business.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/19/22.
//

import Foundation
import SwiftUI

class Business: Decodable, Identifiable, ObservableObject {
    
    @Published var imageData: Data?
    
    var rating: Double?
    var price: String?
    var phone: String?
    var display_phone: String?
    var id: String?
    var alias: String?
    var is_closed: Bool?
    var categories:[Category]?
    var review_count: Int?
    var name: String?
    var url: String?
    var coordinates: Coordinate?
    var image_url: String?
    var location: Location?
    var distance: Double?
    var transactions: [String]?
    
    enum CodingKeys: String, CodingKey {
        case rating
        case price
        case phone
        case display_phone
        case id
        case alias
        case is_closed
        case categories
        case review_count
        case name
        case url
        case coordinates
        case image_url
        case location
        case distance
        case transactions
    }
    
    func getImageData() {
        // Check image url is not nil
        guard image_url != nil else {
            return
        }
        
        // Download the data for the image
        if let url = URL(string: image_url!) {
            // Get a session
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    // Set the image
                    DispatchQueue.main.async {
                        self.imageData = data!
                    }
                    
                }
            }
            dataTask.resume()
        }
    }
}

struct Location: Decodable {
    var city: String?
    var country: String?
    var address2: String?
    var address3: String?
    var state: String?
    var address1: String?
    var zip_code: String?
    var display_address: [String]?
}

struct Category: Decodable {
    var alias: String?
    var title: String?
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}
