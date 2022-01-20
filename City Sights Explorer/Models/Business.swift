//
//  Business.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/19/22.
//

import Foundation

struct Business: Decodable, Identifiable {
    var rating: Double?
    var price: String?
    var phone: String?
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
}

struct Location: Decodable {
    var city: String?
    var country: String?
    var address2: String?
    var address3: String?
    var state: String?
    var address1: String?
    var zip_code: String?
}

struct Category: Decodable {
    var alias: String?
    var title: String?
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}
