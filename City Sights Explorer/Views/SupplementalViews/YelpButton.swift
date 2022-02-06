//
//  YelpButton.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 2/5/22.
//

import SwiftUI

struct YelpButton: View {
    var link:String
    var body: some View {
        Link(destination: URL(string: link)!) {
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height:36)
        }
    }
}

struct YelpButton_Previews: PreviewProvider {
    static var previews: some View {
        YelpButton(link: "https://yelp.us")
    }
}
