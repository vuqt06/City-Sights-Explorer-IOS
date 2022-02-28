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
    @State var tabSelected = 0
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                if !isMapShowing {
                    // Show list view
                    VStack {
                        HStack {
                            Image(systemName: "location")
                            Text(model.placeMark?.locality ?? "")
                            Spacer()
                            Button {
                                self.isMapShowing = true;
                            } label: {
                                Image(systemName: "map.fill")
                            }.foregroundColor(.black)
                            
                        }
                        Divider()
                        ZStack(alignment: .top) {
                            TabView(selection: $tabSelected) {
                                BusinessList(title: "Restaurants", businesses: model.restaurants)
                                    .tabItem{
                                        VStack {
                                            Image(systemName: "fork.knife")
                                            Text("Restaurants")
                                        }
                                    }
                                    .tag(0)
                                BusinessList(title: "Sights", businesses: model.sights)
                                    .tabItem{
                                        VStack {
                                            Image(systemName: "building.columns")
                                            Text("Sights")
                                        }
                                    }
                                    .tag(1)
                                
                                BusinessList(title: "Hotels", businesses: model.hotels)
                                    .tabItem{
                                        VStack {
                                            Image(systemName: "building")
                                            Text("Hotels")
                                        }
                                    }
                                    .tag(2)
                                
                                BusinessList(title: "Fitness", businesses: model.fitness)
                                    .tabItem{
                                        VStack {
                                            Image(systemName: "figure.walk")
                                            Text("Fitness")
                                        }
                                    }
                                    .tag(2)
                            }
                            //BusinessList()
                            
                            HStack {
                                Spacer()
                                YelpButton(link: "https://yelp.us")
                                    .padding(.trailing, -20)
                            }
                        }
                        Divider()
                        Spacer()
                    }.padding(.horizontal)
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                }
                else {
                    ZStack(alignment: .top) {
                        // Show map view
                        BusinessMap(selcectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                // Create business detail view instance and pass in selected business
                                BusinessDetailView(business: business)
                            }
                        
                        ZStack() {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            HStack {
                                Image(systemName: "location")
                                Text(model.placeMark?.locality ?? "")
                                Spacer()
                                Button {
                                    self.isMapShowing = false;
                                } label: {
                                    Image(systemName: "list.dash")
                                }
                                .foregroundColor(.black)
                            }
                            .padding()
                        }
                        .padding()
                    }.navigationBarHidden(true)
                        .statusBar(hidden: true)
                   
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
