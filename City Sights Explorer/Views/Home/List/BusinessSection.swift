//
//  BusinessSection.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/20/22.
//

import SwiftUI

struct BusinessSection: View {
    var title: String
    var businesses: [Business]
    var body: some View {
        Section(header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) {
                business in
                BusinessRow(business: business)
            }
        }
    }
}
