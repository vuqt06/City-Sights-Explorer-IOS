//
//  HomeView.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/20/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model:ContentModel
    @State var isMapShowing = false
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            // Determine if we should show map or list
            if !isMapShowing {
                // Show list view
                VStack {
                    HStack {
                        Image(systemName: "location")
                        Text("San Diego")
                        Spacer()
                        Text("Switch to map view")
                    }
                    BusinessList()
                    Divider()
                }.padding(.horizontal)
            }
            else {
                // Show map view
            }
            
        }
        else {
            // Still waiting for data
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
