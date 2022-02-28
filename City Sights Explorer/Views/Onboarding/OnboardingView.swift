//
//  OnboardingView.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 2/3/22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var model:ContentModel
    @State private var tabSelection = 0
    
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    var body: some View {
        VStack {
            // Tab View
            TabView(selection: $tabSelection) {
                // First tab
                VStack(spacing: 20) {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Explorer")
                        .bold()
                        .font(.title)
                    Text("City Explorer helps you discover your city!")
                       
                }.multilineTextAlignment(.center)
                .tag(0)
                // Second tab
                VStack(spacing: 20) {
                    Image("city3")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    Text("We will show you the best restaurants, sights, hotels, and fitness centers!")
                        
                }.multilineTextAlignment(.center)
                    .padding()
                .tag(1)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // Button
            Button {
                // Detect which tab it is selected
                if tabSelection == 0 {
                    tabSelection = 1
                }
                else {
                    // Request for location
                    model.requestLocationPermission()
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(turquoise)
                        .frame(height: 48)
                        .cornerRadius(5)
                    Text(tabSelection == 0 ? "Get Started" : "Get My Location")
                        .bold()
                        .padding()
                }.foregroundColor(.white)
                    .padding()
            }

        }.ignoresSafeArea()
            .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
