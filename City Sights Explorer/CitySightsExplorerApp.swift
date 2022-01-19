//
//  CitySightsExplorerApp.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/19/22.
//

import SwiftUI

@main
struct CitySightsExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView().environmentObject(ContentModel())
        }
    }
}
