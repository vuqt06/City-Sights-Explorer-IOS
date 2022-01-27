//
//  BusinessTitle.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/27/22.
//

import SwiftUI

struct BusinessTitle: View {
    var business: Business
    var body: some View {
        VStack(alignment: .leading) {
            // Business Name
            Text(business.name!)
                .font(.largeTitle)
            // Address
            if business.location?.display_address != nil {
                ForEach(business.location!.display_address!, id: \.self) {
                    display in
                    Text(display)
                }
            }
            
            // rating
            Image("regular_\(business.rating ?? 0)")
        }
    }
}
