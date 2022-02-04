//
//  LocationDeniedView.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 2/3/22.
//

import SwiftUI

struct LocationDeniedView: View {
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to access your location to provide the best retaurants, sights, and hotels!")
            
            Spacer()
            
            Button {
                // Open setting
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        // If we can open setting, open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(backgroundColor)
                        .frame(height: 48)
                        .cornerRadius(5)
                    
                    Text("Go to Settings")
                        .bold()
                        
                }.padding()
                    .foregroundColor(.white)
            }
            
            Spacer()

        }.multilineTextAlignment(.center)
        .ignoresSafeArea()
        
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
