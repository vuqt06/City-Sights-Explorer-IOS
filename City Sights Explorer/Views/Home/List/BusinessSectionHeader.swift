//
//  BusinessSectionHeader.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/20/22.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title:String
    var body: some View {
        
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 45)
            
            Text(title)
                .font(.title)
                .bold()
        }
        
    }
}

struct BusinessSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeader(title: "Restaurants")
    }
}
