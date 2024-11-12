//
//  URBNApp.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI
import SwiftData

@main
struct URBNApp: App {
    @State private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                ContentView()
            } else {
                LocationDeniedView()
            }
        }
        .modelContainer(for: TripDestination.self)
        .environment(locationManager)
    }
}
