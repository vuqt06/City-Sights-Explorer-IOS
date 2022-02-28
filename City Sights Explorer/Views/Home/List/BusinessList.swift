//
//  BusinessList.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/20/22.
//

import SwiftUI

struct BusinessList: View {
    @EnvironmentObject var model:ContentModel
    var title: String
    var businesses: [Business]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                //BusinessSection(title: "Restaurants", businesses: model.restaurants)
                BusinessSection(title: title, businesses: businesses)
                //BusinessSection(title: "Sights", businesses: model.sights)
                //BusinessSection(title: "Hotels", businesses: model.hotels)
                
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList(title: "", businesses: [Business]())
    }
}
