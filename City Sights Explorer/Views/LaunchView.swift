//
//  LaunchView.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/19/22.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    @EnvironmentObject var model:ContentModel
    var body: some View {
        // Detect the authorization status of geolocating the user
        
        if model.authorizatonStatus == .notDetermined {
            // If undetermined, show onboarding
            OnboardingView()
        }
        else if model.authorizatonStatus == CLAuthorizationStatus.authorizedWhenInUse || model.authorizatonStatus == CLAuthorizationStatus.authorizedAlways {
            // If aproved, show home view
            HomeView()
        }
        else {
            // If denied, show denied view
            LocationDeniedView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView().environmentObject(ContentModel())
    }
}
