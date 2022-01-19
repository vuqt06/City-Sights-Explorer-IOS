//
//  BusinessSearch.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/19/22.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
