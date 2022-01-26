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
    @State var selectedBusiness:Business?
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                if !isMapShowing {
                    // Show list view
                    VStack {
                        HStack {
                            Image(systemName: "location")
                            Text("San Diego")
                            Spacer()
                            Button("Switch to map view") {
                                self.isMapShowing = true;
                            }
                        }
                        BusinessList()
                        Divider()
                    }.padding(.horizontal)
                        .navigationBarHidden(true)
                }
                else {
                    // Show map view
                    BusinessMap(selcectedBusiness: $selectedBusiness)
                        .ignoresSafeArea()
                        .sheet(item: $selectedBusiness) { business in
                            // Create business detail view instance and pass in selected business
                            BusinessDetailView(business: business)
                        }
                }
            }
            // Determine if we should show map or list
            
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
